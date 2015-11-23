class User < ActiveRecord::Base

  has_many :items

  validates_uniqueness_of :email
  validates :email, presence: true
  validates :password, presence: true

end