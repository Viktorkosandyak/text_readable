class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :validatable,
  :jwt_authenticatable,
  jwt_revocation_strategy: JwtBlacklist

  has_many :posts, dependent: :destroy
end