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

require 'rails_helper'

RSpec.describe UserFriend, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
