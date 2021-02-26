# frozen_string_literal: true

require 'rails_helper'

feature 'Upgrade downgrade user' do
  let!(:user) { create(:user, name: 'test_name', surname: 'test_surname') }
  let!(:admin) { create(:user, role: 'admin') }

  context 'admin' do
    scenario 'tries to see user info' do
      sign_in(admin)
      visit user_path(user)

      expect(page).to have_content user.name
      expect(page).to have_link 'Delete user'

      click_on 'Delete user'

      expect(page).to have_content 'Users'
      expect(page).to_not have_content user.email
    end
  end
end
