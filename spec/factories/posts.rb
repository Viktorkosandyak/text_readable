FactoryBot.define do
  factory :post do
    content { "PostgreSQL is a powerful, open source object-relational database system "}
    user { nil }
  end
end
