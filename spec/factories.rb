Factory.define :user do |user|
  user.name                   "Casey Li"
  user.email                  "casey.li@gmail.com"
  user.password               "password"
  user.password_confirmation  "password"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end