FactoryBot.define do
  factory :user do
    email { "viktor123@gmail.com" }
    password { "viktor123" }
    admin { true }
  end
end
  