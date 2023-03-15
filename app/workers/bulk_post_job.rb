class BulkPostJob
  include Sidekiq::Job
  sidekiq_options tags: ['tag1', '🥇'], retry: 1#, queue: 'bulk_post_job'

  # visit https://github.com/mperham/sidekiq/wiki/Advanced-Options#workers to see available options

  def perform(type = 's', count = 10)
    sleep(2.seconds)
    puts "** Starting bulk creation @ #{Time.now} count: #{count}**"
    type == 'single' ? single_insert(count) : multi_insert(count)
    puts "** Finished bulk creation @ #{Time.now} **"
  end

  private

  def single_insert(count)
    puts "#{'🚨' * 4} single_insert  #{'🚨' * 4}"
    (0..count).each { Post.create!(name: Faker::Name.name, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph) }
  end

  def multi_insert(count)
    puts "#{'Ⓜ️' * 4} multi_insert  #{'Ⓜ️' * 4}"
    posts = (1..count).map do
      { name: Faker::Name.name, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph }
    end
    Post.create!(posts)
  end
end
