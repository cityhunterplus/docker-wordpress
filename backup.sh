#!/bin/sh

# 引数チェック。
if [ $# -lt 1 ]; then
	echo $0 "<mysql data container name>"
	echo $0 "<mysql data container name> <backup file>"
	exit 1
fi

# 出力ファイル名を決定。
TODAY=`date '+%F_%H%M'`
OUTPUT_FILE=backup-$TODAY.tar

if [ $# -ge 2 ]; then
    OUTPUT_FILE=$2
fi

# ① mysql のデータコンテナからデータをバックアップ。
docker run --rm --volumes-from $1 -v $(pwd):/backup ubuntu tar zcvf /backup/backup_mariadb.tar.gz -C /var/lib mysql

# ② volumes でリンクしたディレクトリからデータをバックアップ。
# 次のファイル群はバックアップしないようにする。
# ア） sass のキャッシュファイル
# イ） node_modules
# ウ） .DS_Store
tar zcvf backup_wordpress.tar.gz html --exclude .sass-cache node_modules .DS_Store

# ①、② でアーカイブしたものを 1 つのファイルにまとめる。
tar cvf $OUTPUT_FILE backup_mariadb.tar.gz backup_wordpress.tar.gz

# 一時アーカイブファイルを削除。
rm -f backup_mariadb.tar.gz
rm -f backup_wordpress.tar.gz
