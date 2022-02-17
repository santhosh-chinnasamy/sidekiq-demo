class BulkPostJobV2
  include Sidekiq::Job
  sidekiq_options tags: ['tag2', '🥇']

  # visit https://github.com/mperham/sidekiq/wiki/Complex-Job-Workflows-with-Batches
  
  def perform(post)
    Post.create!(post)
  end

  def self.create(count)
    count.times do
      post = { name: Faker::Name.name, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph }
      perform_async(post)
    end
  end
end
