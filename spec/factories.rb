FactoryGirl.define do
  factory :user do
    username              "testuser"
    firstname             "Test"
    lastname              "User"
    email                 "test.user@example.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end