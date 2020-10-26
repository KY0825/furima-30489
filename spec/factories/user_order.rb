FactoryBot.define do
  factory :user_order do
    postal_code      {"111-1111"}
    prefecture_id    {"2"}
    city             {"大阪府"}
    address          {"大阪市淀川区1111-1111"}
    building_name    {"テストマンション1111"}
    phone_number     {"09012341234"}
    token            {"12345abcde67890"}

    association :user
    association :item

  end
end