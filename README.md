# README

```
bundle install
rails db:create db:migrate
```
run `bundle sidekiq -c 1` or `bundle sidekiq -C config/sidekiq.yml` to see execution of jobs.

## references
- [Sidekiq Wiki](https://github.com/mperham/sidekiq/wiki/)
- [Sidekiq options](https://github.com/mperham/sidekiq/wiki/Advanced-Options#workers)
- [Bulk queueing](https://github.com/mperham/sidekiq/wiki/Bulk-Queueing)
- [Bulk queueing 2](https://github.com/mperham/sidekiq/wiki/Complex-Job-Workflows-with-Batches)
