if Sidekiq.server?
  #  Sidekiq::Cron::Job.create(name: 'Scheduler - Every 10 sec', cron: '*/0.1 * * * *', class: 'Scheduler')
end