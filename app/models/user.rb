class User < ActiveRecord::Base

  has_many :items

  validates_uniqueness_of :email

end