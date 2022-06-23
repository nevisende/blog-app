require 'rails_helper'

RSpec.describe 'Users page', type: :feature do
  before :each do
    @user1 = User.create!(email: 'anuar@gmail.com', password: '123456',
                          name: 'Anuar', bio: 'Anuar\'s bio...',
                          photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80')

    @user2 = User.create!(email: 'evren@gmail.com', password: 'abcdef',
                          name: 'Evren', bio: 'Evren\'s bio...',
                          photo: 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80')

    visit '/users/sign_in'
    fill_in 'Username/Email', with: 'evren@gmail.com'
    fill_in 'Password', with: 'abcdef'
    click_button 'Log in'

    @post1 = @user1.posts.create!(title: 'test_1', text: 'Test cases 1')
    @post2 = @user1.posts.create!(title: 'test_2', text: 'Test cases 2')
    @post3 = @user1.posts.create!(title: 'test_3', text: 'Test cases 3')
    @post4 = @user1.posts.create!(title: 'test_4', text: 'Test cases 4')

    visit user_path(@user1)
  end

  it "should see the user's profile picture" do
    image_url = page.find('img.user-card-photo')['src']
    expect(image_url).to eq('https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80')
  end

  it "should see the user's username" do
    expect(page).to have_content('Anuar')
  end

  it 'should see the number of posts the user has written' do
    expect(page).to have_content('Number of Posts : 4')
  end

  it "should see the user's bio" do
    expect(page).to have_content('Anuar\'s bio...')
  end

  it "should see the user's first 3 posts" do
    expect(page).to have_content('test_4')
    expect(page).to have_content('test_3')
    expect(page).to have_content('test_2')
    expect(page).not_to have_content('test_1')
  end

  it "should see a button that lets me view all of a user's posts" do
    expect(page).to have_link('See all posts')
  end

  it "should redirect to post's show page when clicked on a post" do
    click_link 'test_3'
    expect(current_path).to eq(user_post_path(@user1, @post3))
  end

  it "should redirect to the user's post's index page when clicked to see all posts" do
    click_link 'See all posts'
    expect(current_path).to eq(user_posts_path(@user1))
  end
end