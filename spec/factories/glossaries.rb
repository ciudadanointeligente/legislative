# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :glossary do
    term "MyString"
    definition "MyText"
  end
end
