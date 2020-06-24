FactoryBot.define do
  factory :user do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test.jpg")) }
    sequence(:name) { |n| "User#{n}"}
    sex { "男性" }
    age { "10~19才" }
    sequence(:email) { |n| "User#{n}@example.com" }
    password {"password"}
    password_confirmation {"password"}
  end

  trait :with_image do
    image { File.new("#{Rails.root}/spec/fixtures/test.jpg") }
  end

  trait :invalid do
    name {nil}
  end
end