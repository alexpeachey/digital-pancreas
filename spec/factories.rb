Factory.define :user do |f|
  f.sequence(:user_name) { |n| "user#{n}" }
  f.sequence(:email) { |n| "user#{n}@foo.com" }
  f.password "password"
  f.password_confirmation "password"
end

Factory.define :glucose_reading do |f|
  f.association :user
  f.glucose 80 + rand(40)
  f.meal_code 1 + rand(6)
  f.reading_at  Time.now
end