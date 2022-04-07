require 'spec_helper'

RSpec.describe User, type: :model do
  it 'Create 2 posts' do
    user = User.create!(name: 'Mark Den',
                        photo: 'https://images.unsplash.com/photo-1511367461989-f85a21fda167?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1631&q=80',
                        bio: 'Test bio', posts_counter: 0)

    first_post = Post.create!(author: user, title: 'Hello', text: 'This is my first post')
    second_post = Post.create!(author: user, title: 'Hola', text: 'Esta es mi primera publicación')

    recent_created = user.recent_posts
    expect(recent_created[0].id).to be first_post.id
    expect(recent_created[1].id).to be second_post.id
  end

  it 'shouldnt be valid for creation user when posts counter is blank' do
    wrong_user = User.create(name: 'Furkan')
    expect(wrong_user).to_not be_valid
  end

  it 'shouldnt be valid for creation user when name and posts counter are blank' do
    wrong_user = User.create
    expect(wrong_user).to_not be_valid
  end

  it 'should create user' do
    valid_user = User.create(name: 'Bob', posts_counter: 0)
    expect(valid_user).to be_valid
  end

  it 'shouldnt be valid for creation user where name is blank' do
    wrong_user = User.create(posts_counter: 0)
    expect(wrong_user).to_not be_valid
  end
end
