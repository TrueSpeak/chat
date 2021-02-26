# frozen_string_literal: true

require 'rails_helper'

feature 'Upgrade downgrade user' do
  let!(:user) { create(:user, name: 'test_name', surname: 'test_surname') }
  let!(:admin) { create(:user, role: 'admin') }
  let!(:moderator) { create(:user, role: 'moderator') }

  context 'guest' do
    scenario 'tries to see user info' do
      visit user_path(user)

      expect(page).to have_content 'Access denied. You need to authorize'
    end
  end

  context 'user' do
    scenario 'tries to see user info' do
      sign_in(user)
      visit user_path(user)

      expect(page).to have_content user.name
      expect(page).to have_content user.surname
      expect(page).to have_content user.role
      expect(page).to_not have_link 'Upgrade to moderator'
      expect(page).to_not have_link 'Downgrade to default'
      expect(page).to_not have_link 'Delete user'
    end
  end

  context 'moderator' do
    scenario 'tries to see user info' do
      sign_in(moderator)
      visit user_path(user)

      expect(page).to have_content user.name
      expect(page).to have_content user.surname
      expect(page).to have_content user.role
      expect(page).to_not have_link 'Upgrade to moderator'
      expect(page).to_not have_link 'Downgrade to default'
      expect(page).to_not have_link 'Delete user'
    end
  end

  context 'admin' do
    scenario 'tries to see user info' do
      sign_in(admin)
      visit user_path(user)

      expect(page).to have_content user.name
      expect(page).to have_content user.surname
      expect(page).to have_content 'user'
      expect(page).to have_link 'Upgrade to moderator'
      expect(page).to have_link 'Downgrade to default'
      expect(page).to have_link 'Delete user'

      click_on 'Upgrade to moderator'

      expect(page).to have_content 'moderator'
      expect(page).to have_content 'successfully upgraded to moderator'

      click_on 'Downgrade to default'

      expect(page).to have_content 'user'
      expect(page).to have_content 'successfully downgraded to default'
    end
  end
end
