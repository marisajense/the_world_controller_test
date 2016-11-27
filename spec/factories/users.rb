FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "user#{n}@test.com"
    end

    password "Hunter2"
  end
end
