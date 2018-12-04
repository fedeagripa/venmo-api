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
  validates :amount, inclusion: { in: 1..1000, message: 'Amount should be between 1 & 1000' }

  belongs_to :user
  belongs_to :receiver, class_name: User.to_s, foreign_key: 'receiver_id'

  def title
    "#{user.full_name} paid #{receiver.full_name} on #{created_at} regarding: #{description}"
  end

  private

  def ensure_receiver_is_friend
    errors.add(:receiver_id, :not_friends) unless user.friends.include?(receiver)
  end
end
