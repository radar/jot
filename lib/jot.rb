# frozen_string_literal: true

require "jwt"
require_relative "jot/version"
require_relative "jot/configuration"
require_relative "jot/rails/authentication_helper"

class Jot
  class << self
    attr_reader :config
  end

  def self.configure(&block)
    @config = Configuration.new
    block.call(@config)
  end

  def self.encode(payload)
    exp = payload[:exp] || Time.now + config.expiration_time_in_seconds
    JWT.encode(payload.merge(exp: exp.to_i), config.secret, config.algorithm)
  end

  def self.decode(payload, verify: true)
    data, _algorithm = original_decode(payload, verify: verify)
    data
  end

  def self.original_decode(payload, verify: true)
    JWT.decode(payload, config.secret, verify, { algorithm: config.algorithm })
  end
end
