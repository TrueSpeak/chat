require 'rails_helper'

RSpec.describe BlackList, type: :model do
  describe 'associations' do
    it { should have_one(:user) }
  end

  describe 'validations' do
    it { should validate_presence_of(:user_id) }
  end
end
