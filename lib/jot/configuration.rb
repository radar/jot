class Jot
  class Configuration
    attr_accessor :algorithm, :secret, :expiration_time_in_seconds

    # Defaults to 1 hour
    def expiration_time_in_seconds
      @expiration_time_in_seconds || 3600
    end
  end
end
