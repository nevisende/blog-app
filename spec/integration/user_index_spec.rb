require 'rails_helper'

RSpec.describe 'Users index page', type: :feature do
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

    visit '/users'
  end

  it 'should see the username of all other users' do
    expect(page).to have_css('h2', text: 'Anuar')
    expect(page).to have_css('h2', text: 'Evren')
  end

  it 'should see the profile picture for each user' do
    img_url1 = page.all('img.user-card-photo')[0]['src']
    img_url2 = page.all('img.user-card-photo')[1]['src']
    img_url3 = page.all('img.user-card-photo')[2]['src']
    expect(img_url1).to eql 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
    expect(img_url2).to eql 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
    expect(img_url3).to eql 'https://images.unsplash.com/photo-1508921912186-1d1a45ebb3c1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80'
  end

  it 'should see the number of posts each user has written' do
    expect(page).to have_content('Number of Posts : 4')
  end

  it "should redirect me to that user's show page when clicked on a user" do
    click_link 'Anuar'
    expect(current_path).to eq(user_path(@user1))
  end
end
