# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :notification do
    departing_from "MyString"
    departing_from_code "MyString"
    arriving_at "MyString"
    arriving_at_code "MyString"
    departing_time "MyString"
    arriving_at "MyString"
    repeating "MyString"
    device "MyString"
  end
end
