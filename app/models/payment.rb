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

class Payment < ApplicationRecord
  validate :ensure_receiver_is_friend

  belongs_to :user
  belongs_to :receiver, class_name: User.to_s, foreign_key: 'receiver_id'

  private

  def ensure_receiver_is_friend
    errors.add(:receiver_id, :not_friends) unless user.friends.include?(receiver)
  end
end
