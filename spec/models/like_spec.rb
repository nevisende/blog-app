require 'rails_helper'

RSpec.describe Like, type: :model do
  it 'update like counter' do
    user = User.create!(name: 'Tom',
                        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                        bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    post = Post.create(author: user, title: 'Hello', comments_counter: 3, likes_counter: 1_590_281)
    like = Like.create(author: user, post: post)
    like.update_likes_counter
    expect(post.likes_counter).to be 1_590_282
  end
end
