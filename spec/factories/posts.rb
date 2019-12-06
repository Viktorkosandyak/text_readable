FactoryBot.define do
  factory :post do
    content { "PostgreSQL allows columns of a table to be defined as variable-length multidimensional arrays." }
    user { nil }
  end
end
