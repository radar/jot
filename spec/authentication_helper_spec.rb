require 'spec_helper'

RSpec.describe Jot do
  before do
    Jot.configure do |config|
      config.algorithm = "HS256"
      config.secret = "super special secret"
    end
  end

  let(:test_class) do
    Class.new do
      include Jot::Rails::AuthenticationHelper
    end
  end

  let(:request) do
    double(:request, headers: { "Authorization" => "Bearer #{encoded_token}" })
  end

  let(:expected_payload) { { "user_id" => 1 } }

  context "with a valid token" do
    let(:encoded_token) { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.AB5QoOZ8EYxtqbHd5CTdZOwZjUyHpazJVVCk0zejBAI" }

    it "decodes a token using the configured algorithm and secret" do
      payload = test_class.new.jot_decode(request)
      expect(payload).to eq(expected_payload)
    end
  end

  context "with an invalid token" do
    let(:encoded_token) { "moo" }

    it "raises an exception with an invalid token" do
      expect { test_class.new.jot_decode(request) }.to raise_error(JWT::DecodeError)
    end
  end

  context "with a manipulated token" do
    let(:encoded_token) { "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.AB5QoOZ8EYxtqbHd5CTdZOwZjUyHpazJVVCk0zej" }

    it "raises an exception with an invalid token" do
      expect { test_class.new.jot_decode(request) }.to raise_error(JWT::VerificationError)
    end
  end
end
