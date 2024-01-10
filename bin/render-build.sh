#!/usr/bin/env bash
# exit on error
set -o errexit # 途中でエラーが発生した時に残りのコマンドが実行されるのを防ぐ


bundle install
rails assets:precompile
rails assets:clean
rails db:reset
rails db:migrate
rails db:seed