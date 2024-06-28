class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # belongs_to :books
  has_many :books, dependent: :destroy
  has_many :favorites, dependent: :destroy
  
  has_many :book_comments, dependent: :destroy
  
  # フォローした、されたの関係
  has_many :relationshops, class_name: "Relationshop", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationshops, class_name: "Relationshop", foreign_key: "followed_id", dependent: :destroy
  
  # 一覧画面で使う
  has_many :followings, through: :relationshops, source: :followed
  has_many :followers, through: :reverse_of_relationshops, source: :follower
  
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length: { maximum: 50}

  has_many :chat_room_users, dependent: :destroy
  has_many :chat_rooms, through: :chat_room_users
  has_many :messages, dependent: :destroy
  
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def follow(user_id)
    relationshops.create(followed_id: user_id)
  end
  
  def unfollow(user_id)
    relationshops.find_by(followed_id: user_id).destroy
  end
  
  def following?(user)
    followings.include?(user)
  end
end
