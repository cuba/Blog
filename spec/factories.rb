FactoryGirl.define do
  factory :user do
    sequence(:username)     { |n| "test.user-#{n}" }
    sequence(:email)        { |n| "test.user#{n}@example.com"}
    sequence(:firstname)    { |n| "Test-#{n}" }
    sequence(:lastname)     { |n| "User-#{n}@example.com"}
    password                "foobar"
    password_confirmation   "foobar"

    factory :admin do
      admin true
    end
  end
end