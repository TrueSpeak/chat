# frozen_string_literal: true

require 'rails_helper'

feature 'List of users' do
  let!(:first_user) { create(:user) }
  let!(:second_user) { create(:user) }

  context 'guest' do
    scenario 'tries to see list of users' do
      visit users_path

      expect(page).to_not have_content first_user.email
      expect(page).to_not have_content second_user.email
      expect(page).to have_content 'Access denied. You need to authorize'
    end
  end

  context 'user' do
    let!(:user) { create(:user) }

    scenario 'tries to see list of users' do
      sign_in(user)
      visit users_path

      expect(page).to_not have_content first_user.email
      expect(page).to_not have_content second_user.email
      expect(page).to have_content 'Access denied. You need to authorize'
    end
  end

  context 'admin' do
    let!(:admin) { create(:user, role: 'admin') }

    scenario 'tries to see list of users' do
      sign_in(admin)
      visit users_path

      expect(page).to have_content first_user.email
      expect(page).to have_content second_user.email
    end
  end
end
