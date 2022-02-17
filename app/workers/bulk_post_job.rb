class BulkPostJob
  include Sidekiq::Job
  sidekiq_options tags: ['tag1', '🥇'], retry: 1

  # visit https://github.com/mperham/sidekiq/wiki/Advanced-Options#workers to see available options

  def perform(type = 's', count = 10)
    sleep(2.seconds)
    puts "** Starting bulk creation @ #{Time.now} **"
    type == 's' ? single_insert(count) : multi_insert(count)
    puts "** Finished bulk creation @ #{Time.now} **"
  end

  private

  def single_insert(count)
    puts "#{'🚨' * 4} single_insert  #{'🚨' * 4}"
    count.times { Post.create!(name: Faker::Name.name, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph) }
  end

  def multi_insert(count)
    puts "#{'Ⓜ️' * 4} multi_insert  #{'Ⓜ️' * 4}"
    posts = (1..count).map do
      { name: Faker::Name.name, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph }
    end
    Post.create!(posts)
  end
end
