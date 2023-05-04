class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :first_name, :last_name, presence: true
  validates :email, uniqueness: true
  
  def giver?
    type == 'giver'
  end

  def gardner?
    type == 'gardner'
  end

end
