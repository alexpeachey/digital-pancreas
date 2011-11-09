Factory.define :user do |f|
  f.sequence(:user_name) { |n| "user#{n}" }
  f.sequence(:email) { |n| "user#{n}@foo.com" }
  f.password "password"
  f.password_confirmation "password"
end