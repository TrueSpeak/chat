require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_one(:black_list) }
    it { should have_many(:comments) }
    it { should have_many(:messages) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:role) }
  end
end
