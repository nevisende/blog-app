class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :title, length: 1..250, presence: true, allow_blank: false
  validates :comments_counter, numericality: { only_integer: true, greater_than: -1 }
  validates :likes_counter, numericality: { only_integer: true, greater_than: -1 }

  def update_posts_counter
    author.increment!(:post_counter)
    author.save
  end

  def recent_comments
    comments.order('created_at DESC').includes(:author).limit(5)
  end
end
