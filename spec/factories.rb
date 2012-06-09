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

  factory :article do
    sequence(:title)      { |n| "Some Article #{n}" }
    content               "Lorem ipsum dit alor"
    abstract              "Lorem ipsum dit alor"
    user
  end
end