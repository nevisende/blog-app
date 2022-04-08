require 'rails_helper'

RSpec.describe Post, type: :model do
  pending "Add some examples to (or delete) #{__FILE__}"
  it 'create post' do
    user = User.create!(name: 'Tom',
                        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                        bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    post = Post.create(author: user, comments_counter: 0, likes_counter: 0, title: 'test')
    expect(post).to be_valid
  end

  it 'Shouldnt be valid on creating post where title is empty' do
    user = User.create!(name: 'Tom',
                        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                        bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    post = Post.create(author: user)
    expect(post).to_not be_valid
  end

  it 'Shouldnt be valid on creating post when title is more than 250 char' do
    user = User.create!(name: 'Tom',
                        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                        bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    post = Post.create(author: user, comments_counter: 0, likes_counter: 0, title: 'test' * 100)
    expect(post).to_not be_valid
  end

  it 'Shouldnt be valid on creating post when likes equal -1' do
    user = User.create!(name: 'Tom',
                        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                        bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    post = Post.create(author: user, comments_counter: 0, likes_counter: -1, title: 'test')
    expect(post).to_not be_valid
  end

  it 'Shouldnt be valid on creating post where comments counter equal -10' do
    user = User.create!(name: 'Tom',
                        photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80',
                        bio: 'Teacher from Mexico.',
                        posts_counter: 0)
    post = Post.create(author: user, comments_counter: -1, likes_counter: 0, title: 'test')
    expect(post).to_not be_valid
  end
end
