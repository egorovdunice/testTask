class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :tasks
  # validates :first_name, presense: true
  # validates :last_name, presense: true
  # validates :email, presence: true, uniqueness: true
end
