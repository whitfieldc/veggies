class Project < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :owner, :class_name => "User"

  has_many :tasks

end
