FactoryBot.define do
  factory :post do
    content { "MyText" }
    index_readability { 1 }
  end
end
