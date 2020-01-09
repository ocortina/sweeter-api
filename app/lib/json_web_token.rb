# This singleton wraps JWT to provide token encoding and decoding methods.
# The encode method will be responsible for creating tokens based on a payload (user id) and expiration period.
# Since every Rails application has a unique secret key, we'll use that as our secret to sign tokens.
# The decode method, on the other hand, accepts a token and attempts to decode it using the same secret used in encoding.
# In the event decoding fails, be it due to expiration or validation,
# JWT will raise respective exceptions which will be caught and handled by the Exception Handler module.

class JsonWebToken
  # secret to encode and decode token
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload, exp = 24.hours.from_now)
    # set expiry to 24 hours from creation time
    payload[:exp] = exp.to_i
    # sign token with application secret
    JWT.encode(payload, HMAC_SECRET)
  end

  def self.decode(token)
    # get payload; first index in decoded Array
    body = JWT.decode(token, HMAC_SECRET)[0]
    HashWithIndifferentAccess.new body
      # rescue from all decode errors
  rescue JWT::DecodeError => e
    # raise custom error to be handled by custom handler
    raise ExceptionHandler::InvalidToken, e.message
  end
end