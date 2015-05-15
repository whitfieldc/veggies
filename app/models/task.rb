class Task < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :project
  # has_and_belongs_to_many :tags
end
