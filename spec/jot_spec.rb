require 'spec_helper'

RSpec.describe Jot do
  before do
    Jot.configure do |config|
      config.algorithm = "HS256"
      config.secret = "super special secret"
    end

    Timecop.freeze("2023-01-01 09:00:00 +1000")
  end

  let(:payload) { { "user_id" => 1 } }

  it "encodes a token using the configured algorithm and secret" do
    expect(Jot.encode(payload)).to eq("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzI1Mjc2MDB9.8GRtF90VtXnN1jxx92pBhBSAMBZHoCwD-Y69-l8lRqY")
  end

  it "encodes a token with a specified exp" do
    expect(Jot.encode(payload.merge(exp: (Time.now + 1500).to_i))).to eq("eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJleHAiOjE2NzI1MjU1MDB9.VUsLoVd_CMCnMu4YwDfAuahttMng_mc_MWv284wS-oc")
  end

  it "decodes a token using the configured algorithm and secret" do
    token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.AB5QoOZ8EYxtqbHd5CTdZOwZjUyHpazJVVCk0zejBAI"
    expect(Jot.decode(token)).to eq(payload)
  end

  it "decodes a token using the configured algorithm and secret, showing algorithm info" do
    token = "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.AB5QoOZ8EYxtqbHd5CTdZOwZjUyHpazJVVCk0zejBAI"
    expect(Jot.original_decode(token)).to eq([payload, { "alg" => "HS256" }])
  end
end
