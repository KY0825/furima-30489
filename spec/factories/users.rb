FactoryBot.define do
  factory :user do
    nickname                {"やーまだ"}
    email                   {Faker::Internet.free_email}
    password                {"123456a"}
    password_confirmation   {password}
    last_name               {"山田"}
    first_name              {"太郎"}
    last_name_kana          {"ヤマダ"}
    first_name_kana         {"タロウ"}
    birthday                {"1980-12-05"}
  end
end