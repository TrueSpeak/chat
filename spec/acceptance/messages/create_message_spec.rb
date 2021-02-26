# frozen_string_literal: true

require 'rails_helper'

feature 'Create message' do
  given!(:user) { create(:user) }
  given!(:another_user) { create(:user) }
  given!(:moderator) { create(:user, role: 'moderator') }

  context 'multiply sessions' do
    scenario 'create message vision for all', js: true do
      Capybara.using_session('guest') do
        visit root_path

        expect(page).to have_content 'Chat'
        expect(page).to_not have_button 'post message'
      end

      Capybara.using_session('another_user') do
        sign_in(another_user)
        visit root_path

        expect(page).to have_content 'Chat'
        expect(page).to have_button 'post message'
      end

      Capybara.using_session('current_user') do
        sign_in(user)
        visit root_path

        expect(page).to have_content 'Chat'
        expect(page).to have_button 'post message'

        fill_in 'Body', with: 'new message'
        click_on 'post message'

        expect(page).to have_css ".message_#{Message.last.id}"

        within ".message_#{Message.last.id}" do
          expect(page).to have_content 'new message'
        end
      end

      Capybara.using_session('another_user') do
        expect(page).to have_css ".message_#{Message.last.id}"

        within ".message_#{Message.last.id}" do
          expect(page).to have_content 'new message'
          expect(page).to_not have_link 'delete'
        end
      end

      Capybara.using_session('moderator') do
        sign_in(moderator)
        visit root_path

        expect(page).to have_css ".message_#{Message.last.id}"

        within ".message_#{Message.last.id}" do
          expect(page).to have_content 'new message'
          expect(page).to have_link 'delete'
        end
      end
    end
  end
end
