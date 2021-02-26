# frozen_string_literal: true

require 'rails_helper'

feature 'Admin visit user page' do
  let!(:user) { create(:user, name: 'test_name', surname: 'test_surname') }
  let!(:admin) { create(:user, role: 'admin') }

  context 'admin' do
    scenario 'can see user info' do
      sign_in(admin)
      visit users_path
      click_on user.email
      expect(page).to have_content user.name
      expect(page).to have_content user.surname
      expect(page).to have_content user.role
      expect(page).to have_link 'Upgrade to moderator'
      expect(page).to have_link 'Downgrade to default'
      expect(page).to have_link 'Delete user'
    end
  end
end
