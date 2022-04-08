require 'spec_helper'

RSpec.describe User, type: :model do
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
