FactoryBot.define do
  factory :comment do
    user { nil }
    article { nil }
    comment_id { 1 }
    body { "MyText" }
  end
end
