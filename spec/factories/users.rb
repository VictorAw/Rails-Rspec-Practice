FactoryGirl.define do
  factory :user do
    username Faker::Hipster.name
    password 'password'
    session_token SecureRandom::urlsafe_base64(16)
  end
end
