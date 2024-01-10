#!/usr/bin/env bash
# exit on error
set -o errexit # 途中でエラーが発生した時に残りのコマンドが実行されるのを防ぐ

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate
bundle exec rake db:seed