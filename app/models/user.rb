class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  
  has_many :appointments
  has_many :conversations, through: :appointments
  has_many :messages

  def giver?
    type == 'Giver'
  end

  def gardener?
    type == 'Gardener'
  end

end
