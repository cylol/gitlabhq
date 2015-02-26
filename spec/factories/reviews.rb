# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :review do
    merge_request nil
    ref "MyString"
  end
end
