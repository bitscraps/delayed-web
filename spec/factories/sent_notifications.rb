# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :sent_notification do
    channel "MyString"
    message "MyString"
  end
end
