require 'bcrypt'

class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :projects, :foreign_key => "owner_id"

  def password
    @password ||= BCrypt::Password.new(password_hash) if password_hash.present?
  end

  def password=(save_password)
    @password ||= BCrypt::Password.create(save_password)
    self.password_hash = @password
  end

  # TODO rename session_key column to access_token
  def access_token
    # access_token = session_key # super
    access_token ||= regenerate_access_token!
  end

  def regenerate_access_token!
    access_token = SecureRandom.hex(10).to_s
    self.update_attribute(:session_key, access_token)
    access_token
  end

end
