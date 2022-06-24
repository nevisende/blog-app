class User < ApplicationRecord
  attr_writer :login

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  validates :name, presence: true
  validates_format_of :name, with: /^[a-zA-Z0-9_.]*$/, multiline: true

  def recent_posts
    posts.order('created_at DESC').limit(3)
  end

  def login
    @login || name || email
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions.to_h).where(['name = :value OR email = :value', { value: login }]).first
    elsif conditions.key?(:name) || conditions.key?(:email)
      where(conditions.to_h).first
    end
  end

  def admin?
    role == 'admin'
  end

  def authenticate(password)
    valid_password?(password)
  end
end
