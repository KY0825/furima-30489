FactoryBot.define do
  factory :item do
    name                    {"テスト"}
    text                    {"テスト"}
    category_id             {"2"}
    status_id               {"2"}
    delivery_charge_id      {"2"}
    delivery_area_id        {"2"}
    days_id           {"2"}
    price                   {"3000"}

    association :user
    # association :category_id
    # association :status_id
    # association :delivery_charge_id
    # association :delivery_area_id
    # association :days_id

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end