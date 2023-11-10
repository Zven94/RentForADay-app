require 'rails_helper'

RSpec.describe User, type: :model do
  before(:all) do
    @user = User.create(
      name: 'Test User',
      email: 'test-email@gmail.com',
      password: 'password',
      password_confirmation: 'password'
    )
  end

  after(:all) do
    @user.destroy
  end
  # pending "add some examples to (or delete) #{__FILE__}"
  # use shoulda-matchers to test validations
  describe 'it should have db columns' do
    it { should have_db_column(:id) }
    it { should have_db_column(:name) }
    it { should have_db_column(:created_at) }
    it { should have_db_column(:updated_at) }
    it { should have_db_column(:email) }
    it { should have_db_column(:encrypted_password) }
  end

  describe 'attributes' do
    it 'should have name' do
      expect(@user.name).to eq('Test User')
    end

    it 'should have email' do
      expect(@user.email).to eq('test-email@gmail.com')
    end

    it 'should have password' do
      expect(@user.password).to eq('password')
    end

    it 'should have password_confirmation' do
      expect(@user.password_confirmation).to eq('password')
    end
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(50) }
  end

  describe 'test validations' do
    it 'should not save user without name' do
      user = User.new(
        email: 'test-email@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.save).to eq(false)
      user.destroy
    end

    it 'is invalid with a name longer than 50 characters' do
      user = User.new(
        name: 'a' * 51,
        email: 'test-email@gmail.com',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user).to_not be_valid
    end

    it 'should not save user without email' do
      user = User.new(
        name: 'Test User',
        password: 'password',
        password_confirmation: 'password'
      )
      expect(user.save).to eq(false)
      user.destroy
    end
  end
end
