FROM wordpress:5.4.1

ENV TZ Asia/Tokyo

RUN apt-get update \
  && apt-get install -y less vim

# Mac 向け hddpd の権限と書き込みディレクトリの権限で問題になる場合の対応
RUN usermod -u 1000 www-data \
  && groupmod -g 1000 www-data
