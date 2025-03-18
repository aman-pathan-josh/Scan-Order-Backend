class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :user_roles, dependent: :destroy
  has_many :roles, through: :user_roles
  has_many :user_restaurants
  has_many :restaurants, through: :user_restaurants, dependent: :destroy
  has_many :reviews
  has_many :orders, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true, format: { with: /\A[A-Za-z0-9._-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}\z/, message: "doesn't match valid format!" }
  validates :phone_number, presence: true, uniqueness: true, format: { with: /\A\d{10}\z/, message: "doesn't match valid format!" }

  after_create :assign_role

  def has_role?(role_name)
    roles.exists?(role: role_name)
  end

  def skip_confirmation_for_api!
    skip_confirmation! if self.new_record? && self.email.present?
  end

  private
  def assign_role
    customer_role = Role.find_or_create_by(role: "customer")
    admin_role = Role.find_or_create_by(role: "admin")

    if invited_to_sign_up?
      self.roles << admin_role
    else
      self.roles << customer_role
    end
  end
end
