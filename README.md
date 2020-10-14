# テーブル設計

## users テーブル

| Column           | Type   | Options     |
| ---------------- | ------ | ----------- |
| nickname         | string | null: false |
| email            | string | null: false |
| password         | string | null: false |
| first_name       | string | null: false |
| last_name        | string | null: false |
| first_name_kana  | string | null: false |
| last_name_kana   | string | null: false |
| birthday         | date   | null: false |


### Association

- has_many :items
- has_many :comments

## items テーブル

| Column          | Type       | Options                        |
| ----------------| ---------- | ------------------------------ |
| item_name       | string     | null: false                    |
| text            | text       | null: false                    |
| category        | integer    | null: false                    |
| status          | integer    | null: false                    |
| delivery_charge | integer    | null: false                    |
| delivery_area   | integer    | null: false                    |
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
| building_name | string     |                                |
| municipality  | string     | null: false                    |
| user          | references | null: false, foreign_key: true |
| item          | references | null: false, foreign_key: true |

### Association

- belongs_to :user
- belongs_to :item