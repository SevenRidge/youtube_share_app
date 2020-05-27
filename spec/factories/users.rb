FactoryBot.define do
  factory :user do
    image { Rack::Test::UploadedFile.new(File.join(Rails.root, "spec/fixtures/test.jpg")) }
    name { "テストユーザー" }
    sequence(:email) { |n| "testuser#{n}@example.com" }
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