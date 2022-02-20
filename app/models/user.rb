class User < ApplicationRecord
  # TODO make teams tansferable
  has_many :teams, dependent: :destroy
  before_save   :downcase_email
  validates :handle, presence: true, length: { maximum: 50}
  validates :name, presence: true, length: { maximum: 50}
  has_many :teams_relationships, dependent: :destroy
  has_many :memberships, through: :teams_relationships, source: :team
  has_many :team_requests, dependent: :destroy
  has_many :requests, through: :team_requests, source: :team
  VALID_EMAIL_REGEX= /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6, maximum: 140 }, allow_nil: true
  validates :password_confirmation, length: { minimum: 6, maximum: 140 }, allow_nil: true
  class << self

    # Returns the hash digest of a given string
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                    BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
    def new_token(user)
      exp = Time.now.to_i + 1.day
      @payload = {
        data: {
          "user_id": user.id
        },
        exp: exp
      }
      return JWT.encode @payload, ENV['HMAC_SECRET'], 'HS256'
    end
  end


  # TODO add some of this functionality
  
  # Remembers a user in the database for use in persistent sessions
  # def remember
  #   self.remember_token = User.new_token
  #   update_attribute(:remember_digest, User.digest(remember_token))
  # end

  # Forgets the user
  # def forget
  #   update_attribute(:remember_digest, nil)
  # end

  # Activates an account.
  # def activate
  #   update_columns(activated: true, activated_at: Time.zone.now)
  # end

  # Sends activation email
  # def send_activation_email
  #   UserMailer.account_activation(self).deliver_now
  # end
  
  # Sets the password reset attributes
  # def create_reset_digest
  #   self.reset_token = User.new_token
  #   update_columns( reset_digest: User.digest(reset_token), reset_sent_at: Time.zone.now)
  # end

  # Sends password reset email
  # def send_password_reset_email
  #   UserMailer.password_reset(self).deliver_now
  # end

  # Returns true if a password reset has expired
  # def password_reset_expired?
  #   reset_sent_at < 2.hours.ago
  # end

  # end

  private

  def downcase_email
    email.downcase!
  end

  # def create_activation_digest
  #   self.activation_token = User.new_token
  #   self.activation_digest = User.digest(activation_token)
  # end
end
