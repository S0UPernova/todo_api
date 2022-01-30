ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all


  def get_new_token(user, expire_date_modifier)
    exp = Time.now.to_i + expire_date_modifier
    payload = {
      data: {
        "user_id": user.id
      },
      exp: exp
    }
    JWT.encode payload, ENV['HMAC_SECRET'], 'HS256'
  end
end