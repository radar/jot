# Jot

A light wrapper around the [JWT gem](https://github.com/jwt/ruby-jwt).

## Setup

Configure the gem:

```ruby
Jot.configure do |config|
  config.algorithm = "HS256"
  config.secret = # Something long and complex, such as a value generated by SecureRandom.hex(32)
end
```

You may wish to also specify the expiration time for tokens as well. The default is 1 hour, but it can be overridden:

```ruby
  config.expiration_time_in_seconds = 1500 # 25 minutes
```

## Usage

Encode a payload:

```ruby
Jot.encode({ user_id: 1 }) # => "eyJhbGciOiJIUz..."
```

Decode a payload:

```ruby
Jot.decode("eyJhbGciOiJIUz...") # => { "user_id" => 1 }
```

Decode a payload and get the header information too:

```ruby
Jot.original_decode("eyJhbGciOiJIUz") # => [{ "user_id" => 1 }, { "alg" => "HS256" }]

```

Exceptions raised for invalid / expired tokens will be the same as those raised by the JWT gem.
