class BaseJob
  class << self
    def queue
      :default
    end

    def enqueue(*args)
      Resque.enqueue(self, *args)
    end
  end
end
