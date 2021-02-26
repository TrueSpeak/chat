# frozen_string_literal: true

require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let!(:user) { create(:user, role: 'user') }
  let!(:admin) { create(:user, role: 'admin') }
  let!(:moderator) { create(:user, role: 'moderator') }

  describe 'GET #index' do
    let!(:records) { create_list(:message, 5) }

    before { get :index }

    context 'guest/user/admin' do
      it 'return list of messages' do
        expect(records).to match_array(Message.all.to_a)
      end

      it 'render index template' do
        expect(response).to render_template :index
      end
    end
  end

  describe 'POST #create' do
    context 'guest' do
      it 'tries to create message' do
        expect do
          post :create, params: { message: { body: 'my message' } }
        end.to_not change(Message, :count)
      end
    end

    context 'authenticate user/moderator/admin' do
      before { login(user) }

      it 'tries to create message' do
        expect do
          post :create, params: { message: { body: 'my message' }, format: :js }
        end.to change(Message, :count).by(1)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:record) { create(:message) }

    context 'guest' do
      it 'tries to delete message' do
        expect do
          delete :destroy, params: { id: record.id }, format: :js
        end.to_not change(Message, :count)
      end

      it 'redirect to root_path' do
        delete :destroy, params: { id: record.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'authenticate user' do
      let!(:record) { create(:message, user: user) }
      before { login(user) }

      it 'tries to delete message' do
        expect do
          delete :destroy, params: { id: record.id }, format: :js
        end.to_not change(Message, :count)
      end

      it 'redirect to root_path' do
        delete :destroy, params: { id: record.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'moderator/admin' do
      let!(:record) { create(:message, user: user) }
      before { login(admin) }

      it 'tries to delete message' do
        expect do
          delete :destroy, params: { id: record.id }, format: :js
        end.to change(Message, :count).by(-1)
      end
    end
  end
end
