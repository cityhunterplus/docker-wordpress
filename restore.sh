#!/bin/sh

# 引数チェック。
if [ $# -lt 2 ]; then
	echo $0 "<mariadb data container name> <backupfile>"
	exit 1
fi

# バックアップファイルを一時アーカイブファイルに展開。
tar xvf $2

# 展開したアーカイブファイルを解凍してデータを戻す。
docker run --rm --volumes-from $1 -v $(pwd):/backup ubuntu bash -c "cd /var/lib && tar zxvf /backup/backup_mariadb.tar.gz"
tar zxvf backup_wordpress.tar.gz

# 一時アーカイブファイルを削除。
rm -f backup_mariadb.tar.gz
rm -f backup_wordpress.tar.gz
