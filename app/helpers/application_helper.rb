module ApplicationHelper
  def decode_token(token)
    leeway = 30 # seconds

    decoded_token = JWT.decode token, ENV['HMAC_SECRET'], true, { exp_leeway: leeway, algorithm: 'HS256' }
    return decoded_token
  end
end
