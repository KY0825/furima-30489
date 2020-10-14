# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| firstl_name      | string | null: false |
| last_name        | string | null: false |
| firstl_name_kana | string | null: false |
| last_name_kana   | string | null: false |
| birthday         | string | null: false |


### Association

- has_many :items
- has_many :comments

## items テーブル

| Column          | Type       | Options                        |
| ----------------| ---------- | ------------------------------ |
| image           | string     | null: false                    |
| item_name       | string     | null: false                    |
| text            | string     | null: false                    |
| category        | string     | null: false                    |
| status          | string     | null: false                    |
| delivery_charge | string     | null: false                    |
| delivery_area   | string     | null: false                    |
| days            | string     | null: false                    |
| price           | string     | null: false                    |
| user            | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- has_many   :comments
- has_one    :shopping_address

## comments テーブル

| Column | Type       | Options                        |
| ------ | ---------- | ------------------------------ |
| text   | text       | null: false                    |
| user   | references | null: false, foreign_key: true |
| item   | references | null: false, foreign_key: true |


### Association

- belongs_to :user
- belongs_to :item

## shipping_address テーブル

| Column        | Type       | Options                        |
| ------------- | ---------- | ------------------------------ |
| postal_code   | string     | null: false                    |
| prefectures   | string     | null: false                    |
| municipality  | string     | null: false                    |
| address       | string     | null: false                    |
| building_name | string     | null: false                    |
| municipality  | string     | null: false                    |
| user          | references | null: false, foreign_key: true |
| room          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item
- has_one :card

## card テーブル

| Column          | Type       | Options                        |
| --------------- | ---------- | ------------------------------ |
| card_number     | string     | null: false                    |
| expiration_date | string     | null: false                    |
| security_code   | string     | null: false                    |

### Association

- shipping_address