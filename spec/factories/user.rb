require 'faker'
FactoryBot.define do
  factory :user do
    email { Faker::Internet.email}
    full_name { Faker::Name.name}
    password { Faker::Internet.password}
    role {'admin'}
  end

  # trait :user1 do
  #   email 'abc@e.com'
  #   full_name 'ABC'
  #   password 'password'
  #   vanity 'v21'
  # end

  # trait :user2 do
  #   email 'abcd@e.com'
  #   full_name 'ABC'
  #   password 'password'
  #   vanity 'v-21'
  # end

  # trait :user3 do
  #   email 'abc13@e.com'
  #   full_name 'ABC'
  #   password 'password'
  #   vanity 'v21'
  # end

  # trait :user4 do
  #   email 'abc14@e.com'
  #   full_name 'ABC'
  #   password 'password'
  # end

  # trait :user5 do
  #   email 'abc15@e.com'
  #   full_name 'ABC1'
  #   password 'password'
  # end

  # trait :user6 do
  #   email 'abc16@e.com'
  #   full_name 'ABC1'
  #   password 'password'
  # end

  # trait :avatar do
  #   avatar { URI.parse(Faker::Placeholdit.image) }
  # end

  # factory :user_without_email do
  #   email ''
  #   full_name 'My String'
  #   password 'password1'
  #   vanity 'v1123'
  # end

  # factory :regular_user do
  #   email 'abc@e.com'
  #   full_name 'My String'
  #   password 'password1'
  #   type 'RegularUser'
  # end
  #
  # factory :regular_user_1, class: :regular_user  do
  #   email 'food@e.com'
  #   full_name 'My String'
  #   password 'password1'
  #   type 'RegularUser'
  # end

end
