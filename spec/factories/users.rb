FactoryBot.define do
  factory :user do
    nickname                {"やーまだ"}
    email                   {"t.yamada@gmail.com"}
    password                {"123456a"}
    password_confirmation   {password}
    last_name               {"山田"}
    first_name              {"太郎"}
    last_name_kana          {"ヤマダ"}
    first_name_kana         {"太郎"}
    birthday                {"1991年8月25日"}
end