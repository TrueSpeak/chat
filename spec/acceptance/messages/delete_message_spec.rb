# frozen_string_literal: true

require 'rails_helper'

feature 'Delete message' do
  given!(:user) { create(:user) }
  given!(:moderator) { create(:user, role: 'moderator') }
  given!(:message) { create(:message, user: user) }

  context 'multiply sessions' do
    scenario 'create message vision for all', js: true do
      Capybara.using_session('guest') do
        visit root_path

        expect(page).to have_css ".message_#{message.id}"

        within ".message_#{message.id}" do
          expect(page).to_not have_link 'delete'
        end
      end

      Capybara.using_session('user') do
        sign_in(user)
        visit root_path

        expect(page).to have_css ".message_#{message.id}"

        within ".message_#{message.id}" do
          expect(page).to_not have_link 'delete'
        end
      end

      Capybara.using_session('moderator') do
        sign_in(moderator)
        visit root_path

        expect(page).to have_css ".message_#{message.id}"

        within ".message_#{message.id}" do
          expect(page).to have_link 'delete'
          click_on 'delete'
        end

        expect(page).to_not have_css ".message_#{message.id}"
      end

      Capybara.using_session('guest') do
        expect(page).to_not have_css ".message_#{message.id}"
      end

      Capybara.using_session('user') do
        expect(page).to_not have_css ".message_#{message.id}"
      end
    end
  end
end
