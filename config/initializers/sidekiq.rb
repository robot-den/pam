# It needed for set SideKiq max_retries if job fails
Sidekiq.configure_server do |config|
   config.server_middleware do |chain|
      chain.add Sidekiq::Middleware::Server::RetryJobs, :max_retries => 0
   end
end