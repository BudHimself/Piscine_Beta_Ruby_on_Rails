class Cuicui < ActiveRecord::Base
  belongs_to :user
  has_many :comments, through: :user
end
