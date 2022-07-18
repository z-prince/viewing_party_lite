class User < ApplicationRecord
  validates_presence_of  :name
  validates_presence_of  :email
  validates_uniqueness_of :email
  validates_presence_of :password
  has_many :party_users
  has_many :parties, through: :party_users

  has_secure_password

  def host?(party_id)
    party_users.where(party_id: party_id).first.host
  end
end
