require 'rails_helper'

RSpec.describe 'Posts index page', type: :feature do
  before :each do
    @user1 = User.create!(email: 'anuar@gmail.com', password: '123456',
                          name: 'Anuar', bio: 'Anuar\'s bio...',
                          photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80')

    @user2 = User.create!(email: 'evren@gmail.com', password: 'abcdef',
                          name: 'Evren', bio: 'Evren\'s bio...',
                          photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80')

    visit '/users/sign_in'
    fill_in 'Username/Email', with: 'anuar@gmail.com'
    fill_in 'Password', with: '123456'
    click_button 'Log in'

    @post1 = @user1.posts.create!(title: 'test_1', text: 'Test cases 1')
    @post2 = @user1.posts.create!(title: 'test_2', text: 'Test cases 2')
    @post3 = @user1.posts.create!(title: 'test_3', text: 'Test cases 3')
    @post4 = @user1.posts.create!(title: 'test_4', text: 'Test cases 4')

    @post1.comments.create!(author: @user1, text: 'comment 1 from user 1')
    @post1.comments.create!(author: @user1, text: 'comment 2 from user 1')
    @post1.comments.create!(author: @user2, text: 'comment 3 from user 2')
    @post1.comments.create!(author: @user2, text: 'comment 4 from user 2')

    @post1.likes.create!(author: @user2)
    @post1.likes.create!(author: @user1)

    visit user_posts_path(@user1)
  end

  it "should see the user's profile picture" do
    image_url = page.find('img')['src']
    expect(image_url).to eq('https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80')
  end

  it "should see the user's username" do
    expect(page).to have_content('Anuar')
  end

  it 'should see the number of posts the user has written' do
    expect(page).to have_content('Number of Posts : 4')
  end

  it "should see a post's title" do
    expect(page).to have_content('test_1')
    expect(page).to have_content('test_2')
    expect(page).to have_content('test_3')
    expect(page).to have_content('test_4')
  end

  it "should see some of the post's body" do
    expect(page).to have_content('Test cases 1')
    expect(page).to have_content('Test cases 2')
    expect(page).to have_content('Test cases 3')
    expect(page).to have_content('Test cases 4')
  end

  it 'should see the first comments on a post' do
    expect(page).to have_content('Comments: 4')
  end

  it 'should see how many comments a post has' do
    expect(page).to have_content('comment 1 from user 1')
    expect(page).to have_content('comment 2 from user 1')
    expect(page).to have_content('comment 3 from user 2')
    expect(page).to have_content('comment 4 from user 2')
  end

  it 'should see how many likes a post has' do
    expect(page).to have_content('Likes: 2')
  end

  it 'should see a section for pagination if there are more posts than fit on the view' do
    expect(page).to have_content('Likes: 2')
  end

  it "should redirect me to post's show page when I click on it" do
    click_link('test_1')
    expect(current_path).to eq(user_post_path(@user1, @post1))
  end
end
