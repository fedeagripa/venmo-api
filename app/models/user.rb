# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  first_name             :string           default("")
#  last_name              :string           default("")
#  username               :string           default("")
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  tokens                 :json
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_uid_and_provider      (uid,provider) UNIQUE
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :uid, uniqueness: { scope: :provider }

  before_validation :init_uid

  has_many :user_friends, foreign_key: 'user_me_id'
  has_many :friends_user, foreign_key: 'user_friend_id', class_name: UserFriend.to_s
  has_many :friends_added, through: :user_friends, class_name: User.to_s,
            source: :user, dependent: :destroy
  has_many :friends_added_me, through: :friends_user, class_name: User.to_s,
            source: :friend, dependent: :destroy
  has_many :payments

  def full_name
    return username unless first_name.present?
    "#{first_name} #{last_name}"
  end

  def friends
    UserFriend.where(user_friend_id: id).or(UserFriend.where(user_me_id: id)).map(&:friend)
  end

  def self.from_social_provider(provider, user_params)
    where(provider: provider, uid: user_params['id']).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.assign_attributes user_params.except('id')
    end
  end

  def send_money(amount)
    transfer_from_bank(amount-balance) if balance < amount
    decrement!(:balance, amount)
  end

  def add_to_balance(amount)
    increment!(:balance, amount)
  end

  def transfer_from_bank(amount)
    increment!(:balance, amount)
  end

  private

  def uses_email?
    provider == 'email' || email.present?
  end

  def init_uid
    self.uid = email if uid.blank? && provider == 'email'
  end
end
