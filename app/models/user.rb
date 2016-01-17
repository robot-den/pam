class User < ActiveRecord::Base

  # Include default devise modules. Others available are: :confirmable, :lockable and :timeoutable
  devise  :database_authenticatable, 
          :registerable, 
          :recoverable, 
          :rememberable, 
          :trackable, 
          :validatable, 
          :omniauthable

  has_many :articles

end
