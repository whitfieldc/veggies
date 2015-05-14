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

  def get_key
    self.session_key ||= SecureRandom.hex(10).to_s
  end

end
