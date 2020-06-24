FactoryBot.define do
  factory :post do
    comment {"this is Factory post"}
    youtube_url {"https://www.youtube.com/watch?v=0AlmxAitmgU"}
    genre {"音楽"}
    user
  end
end
