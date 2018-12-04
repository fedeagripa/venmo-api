# == Schema Information
#
# Table name: user_friends
#
#  id             :integer          not null, primary key
#  user_me_id     :integer          not null
#  user_friend_id :integer          not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :user_friend do
    user { create(:user) }
    friend { create(:user) }
  end
end
