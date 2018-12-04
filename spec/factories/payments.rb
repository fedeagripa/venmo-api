# == Schema Information
#
# Table name: payments
#
#  id          :integer          not null, primary key
#  amount      :integer          not null
#  description :text
#  user_id     :integer
#  receiver_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_payments_on_receiver_id  (receiver_id)
#  index_payments_on_user_id      (user_id)
#

FactoryBot.define do
  factory :payment do
    user { create(:user) }
    receiver { create(:user) }
    amount { Faker::Number.number(3) }
    description { Faker::ChuckNorris.fact }
  end
end
