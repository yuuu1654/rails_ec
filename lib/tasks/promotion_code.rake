# frozen_string_literal: true

# モデルにアクセスする場合は :environment を指定する
# namespace :task_sample do
#   desc "task_sample_use_model"
#   task :task_model => :environment do
#     puts User.first().to_yaml #Userモデルを参照
#   end
# end

namespace :promotion_code do
  desc 'generate promotion codes'
  task generate: :environment do
    # 1度のrake task で10個のプロモコードを作成
    10.times do
      code = SecureRandom.alphanumeric(7)
      discount_amount = rand(100..1000) # 100~1000からランダムで数値を算出 (両端を含む)
      PromotionCode.create!(code:, discount_amount:)
    end

    puts 'プロモーションコードを10個作成しました'
  end
end
