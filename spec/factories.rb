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
    sequence(:content)    { |n| "Lorem ipsum dit alor #{n}" }
    sequence(:abstract)   { |n| "Lorem ipsum dit alor #{n}" }
    user
  end

  factory :comment do
    sequence(:content)    { |n| "Lorem ipsum dit alor #{n}" }
    user
    article
  end
end