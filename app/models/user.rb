class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :projects, :foreign_key => "owner_id"
end
