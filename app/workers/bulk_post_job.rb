class BulkPostJob
  include Sidekiq::Job

  def perform(*args)
    puts "BulkPostJob: #{args}"
  end
end
