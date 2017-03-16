FROM wordpress:4.7.3

# Mac 向け hddpd の権限と書き込みディレクトリの権限で問題になる場合の対応
RUN usermod -u 1000 www-data \
  && groupmod -g 1000 www-data
