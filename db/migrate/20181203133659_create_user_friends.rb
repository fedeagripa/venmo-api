class CreateUserFriends < ActiveRecord::Migration[5.1]
  def change
    create_table :user_friends do |t|
      t.integer 'user_me_id', null: false
      t.integer 'user_friend_id', null: false
      t.timestamps
    end
  end
end
