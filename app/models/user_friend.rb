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

class UserFriend < ApplicationRecord
  belongs_to :user, class_name: User.to_s, foreign_key: 'user_me_id'
  belongs_to :friend, class_name: User.to_s, foreign_key: 'user_friend_id'
end
