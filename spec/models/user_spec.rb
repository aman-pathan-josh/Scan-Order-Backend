require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:user_roles).dependent(:destroy) }
    it { should have_many(:roles).through(:user_roles) }
    it { should have_many(:user_restaurants) }
    it { should have_many(:restaurants).through(:user_restaurants).dependent(:destroy) }
    it { should have_many(:reviews) }
    it { should have_many(:orders).dependent(:destroy) }
  end

  describe 'validations' do
    subject { build(:user) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email).case_insensitive }
    it { should allow_value('email@example.com').for(:email) }
    it { should_not allow_value('email').for(:email) }
    it { should validate_presence_of(:phone_number) }
    it { should validate_uniqueness_of(:phone_number).case_insensitive }
    it { should allow_value('1234567890').for(:phone_number) }
    it { should_not allow_value('12345').for(:phone_number) }
  end

  describe 'callbacks' do
    it 'assigns a role after create' do
      user = create(:user)
      expect(user.roles).not_to be_empty
    end
  end

  describe '#has_role?' do
    it 'should verify user is superadmin or not' do
      role = create(:role, :superadmin)
      user = create(:user)
      user.roles << role

      response = user.has_role?('superadmin')
      expect(response).to be true
    end

    it 'should verify user is admin or not' do
      role = create(:role, :admin)
      user = create(:user)
      user.roles << role

      response = user.has_role?('admin')
      expect(response).to be true
    end

    it 'should verify user is customer or not' do
      role = create(:role, :customer)
      user = create(:user)
      user.roles << role

      response = user.has_role?('customer')
      expect(response).to be true
    end
  end

  describe '#skip_confirmation_for_api!' do
    it 'skips confirmation if user is new and email is present' do
      user = build(:user)
      user.skip_confirmation_for_api!
      expect(user.confirmed?).to be true
    end
  end
end
