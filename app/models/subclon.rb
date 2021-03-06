class Subclon < ActiveRecord::Base
  attr_accessible :name, :creator_id

  validates :name, presence: true
  validates :creator_id, presence: true

  belongs_to(
    :creator,
    :class_name => "User",
    :foreign_key => :creator_id,
    :primary_key => :id
  )
  
  has_many :posts
end