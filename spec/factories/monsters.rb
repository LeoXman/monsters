# t.string   "name"
# t.integer  "level"
# t.integer  "hp"
# t.integer  "exp"
# t.integer  "jexp"
# t.integer  "atk1"
# t.integer  "atk2"
# t.integer  "def"
# t.integer  "mdef"
# t.integer  "str"
# t.integer  "agi"
# t.integer  "vit"
# t.integer  "int"
# t.integer  "dex"
# t.integer  "luk"
# t.integer  "scale"
# t.integer  "race"
# t.integer  "element"
# t.datetime "created_at",              null: false
# t.datetime "updated_at",              null: false
# t.integer  "own"
# t.integer  "like",        default: 0
# t.integer  "dislike",     default: 0
# t.text     "vote_stamps"
FactoryGirl.define do
  factory :monster do
    name "Very dirt"
    level "1234567"
    hp "1234567"
    exp "1234567"
    jexp "1234567"
    atk1 "1234567"
    atk2 "1234567"
    mdef "1234567"
    str "1234567"
    agi "1234567"
    vit "1234567"
    int "1234567"
    dex "1234567"
    luk "1234567"
    scale "1234567"
    race "1234567"
    element "1234567"
  end
end

FactoryGirl.define do
  factory :user do
    level "1234567"
    hp "1234567"
    exp "1234567"
    jexp "1234567"
  end
end
