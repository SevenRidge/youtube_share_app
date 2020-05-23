# ##################### 事前準備 ################################## #
#       nginx.confの[listen]と[server_name]を修正してください         #
#       本ファイルのMAINを実施環境に合わせて修正してください              #
# ############################################################### #

# ##################### 実行方法 ################################## #
#    ディレクトリを作成後、その配下に配置し本スクリプトを実行してください。   # 
# ############################################################### #

# ################## スクリプト実施中の作業依頼     ############################ #
#      スクリプト実施後、enter_password: と表示が2回出てきます。                   # 
#      以下に示すパスワードを入力してください。                                    # 
# 1回目:db.envファイル内の[MYSQL_ROOT_PASSWORD] デフォルト値：db_root_password   #
# 2回目:db.envファイル内の[MYSQL_PASSWORD] デフォルト値: user_password           #
# ######################################################################### #

# 資源格納のフルパス
MAIN=/Users/Nanao/work/rails/make_docker_env

# dockerコンテナを作成するディレクトリの作成
chown -R $USER:$USER $(pwd)
cp -r $MAIN/main/* ./

# Railsアプリの生成
docker-compose run --rm app rails new . --force --database=mysql --skip-bundle

# 権限の変更
sudo chown -R $USER:$USER .

#puma.rbの移動
cp $MAIN/env/puma.rb ./config/

#database.ymlの移動
cp $MAIN/env/database.yml ./config/

# dockerコマンド実行
docker-compose build
docker-compose up -d

# 結果
echo ===docker imagesの結果===
docker images
echo ===docker psの結果===
docker-compose ps

# DBの作成
cp $MAIN/env/grant_user.sql ./db/
docker-compose exec db mysql -u root -p -e"$(cat db/grant_user.sql)"
docker-compose exec db mysql -u user_name -p -e"show grants;"
docker-compose exec app rails db:create
docker-compose exec app bash after_make_container.sh
docker-compose exec app rm after_make_container.sh

# ページがうまく表示できないときがあるので、コンテナを再起動
docker-compose restart