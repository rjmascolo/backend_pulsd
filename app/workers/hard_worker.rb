class HardWorker
  include Sidekiq::Worker

  def perform(*args)
    byebug;
  end
end
