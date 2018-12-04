json.feed @payments do |pay|
  json.user pay.user.id
  json.receiver pay.receiver.id
  json.amount pay.amount
  json.title pay.title
end