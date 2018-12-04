# Users
u1 = User.find_or_create_by(email: 'user1@gmail.com', first_name: 'user', last_name: '1')
u1.update!(password: 'user1111')
u2 = User.find_or_create_by(email: 'user2@gmail.com', first_name: 'user', last_name: '2')
u2.update!(password: 'user2222')
u3 = User.find_or_create_by(email: 'user3@gmail.com', first_name: 'user', last_name: '3')
u3.update!(password: 'user3333')
# Friends
UserFriend.find_or_create_by(user: User.find(1), friend: User.find(2))
UserFriend.find_or_create_by(user: User.find(1), friend: User.find(3))
UserFriend.find_or_create_by(user: User.find(2), friend: User.find(3))
# Payments
Payment.find_or_create_by(user: User.find(1), receiver: User.find(2), amount: 100, description: 'some text')
Payment.find_or_create_by(user: User.find(2), receiver: User.find(3), amount: 100, description: 'take some money')
