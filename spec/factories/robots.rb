FactoryGirl.define do
  factory :robot do
    serial "1234"
    friendly true

    trait :good do
      name "Good Guy robot"
      friendly true
    end

    trait :evil do
      name "Evil Bob"
      friendly false
    end
  end
end
