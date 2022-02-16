class BulkPostJob
  include Sidekiq::Job

  def perform(count)
    # count&.times do |i|
    #   puts "Posting #{i}"
    #   Post.create!(name: Faker::Name.name, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph)
    #   puts "Posted #{i}"
    # end

    puts "Starting bulk creation @ #{Time.now}"
    posts = (1..count).map do
      { name: Faker::Name.name, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph }
    end
    Post.create!(posts)
    puts "Finished bulk creation @ #{Time.now}"
  end
end
