class JvtCoder
  DECODING_JWT_KEY = ENV['jwt_secret']

  class << self
    def encode(payload)
      JWT.encode(payload, DECODING_JWT_KEY)
    end

    def decode(token)
      JWT.decode(token, DECODING_JWT_KEY, true, algorithm: "HS256")
    end
  end
end
