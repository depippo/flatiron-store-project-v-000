class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :carts
  has_many :orders
  has_one :current_cart, class: Cart

  def create_current_cart
    cart = carts.create
    self.current_cart_id = cart.id
    save
  end
  
end
