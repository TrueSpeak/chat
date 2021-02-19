require 'rails_helper'

RSpec.describe BlackListedUser, type: :model do
  describe 'associations' do
    it { should belong_to(:black_list) }
  end

  describe 'validations' do
    it { should validate_presence_of(:black_list_id) }
    it { should validate_presence_of(:user_id) }
  end
end
