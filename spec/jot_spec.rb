require 'spec_helper'

RSpec.describe Jot do
  before do
    Jot.configure do |config|
      config.algorithm = "HS256"
      config.secret = "super special secret"
    end
  end

  let(:payload) { { "user_id" => 1 } }

  it "encodes a token using the configured algorithm and secret" do
    expect(Jot.encode(payload)).to eq("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.AB5QoOZ8EYxtqbHd5CTdZOwZjUyHpazJVVCk0zejBAI")
  end

  it "decodes a token using the configured algorithm and secret" do
    token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.AB5QoOZ8EYxtqbHd5CTdZOwZjUyHpazJVVCk0zejBAI"
    expect(Jot.decode(token)).to eq([payload, { "alg" => "HS256" }])
  end
end
