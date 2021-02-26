# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let!(:user) { create(:user, role: 'user') }
  let!(:admin) { create(:user, role: 'admin') }
  let!(:moderator) { create(:user, role: 'moderator') }
  let!(:record) { create(:user) }

  describe 'GET #show' do
    context 'when guest tries to get show user' do
      before do
        get :show, params: { id: record.id }
      end

      it 'redirect to root path' do
        expect(response).to redirect_to root_path
      end
    end

    context 'when authenticated user tries to get show user' do
      before do
        login(user)
        get :show, params: { id: record.id }
      end

      it 'render show view' do
        expect(response).to render_template(:show)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when guest tries to delete user' do
      it 'not delete' do
        expect do
          delete :destroy, params: { id: record.id }
        end.to_not change(User, :count)
      end

      it 'redirect guest to root_path' do
        delete :destroy, params: { id: record.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'when authenticated user tries to delete user' do
      before { login(user) }

      it 'not delete' do
        expect do
          delete :destroy, params: { id: record.id }
        end.to_not change(User, :count)
      end

      it 'redirect user to root_path' do
        delete :destroy, params: { id: record.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'when admin tries to delete user' do
      before { login(admin) }

      it 'delete' do
        expect do
          delete :destroy, params: { id: record.id }
        end.to change(User, :count).by(-1)
      end

      it 'redirect admin to users_path' do
        delete :destroy, params: { id: record.id }
        expect(response).to redirect_to users_path
      end
    end
  end

  describe 'GET #index' do
    context 'when guest tries to get list of users' do
      it 'redirect guest to root_path' do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context 'when authenticated user tries to get list of users' do
      before { login(user) }

      it 'redirect user to root_path' do
        get :index
        expect(response).to redirect_to root_path
      end
    end

    context 'when moderator tries to see list of users' do
      before { login(moderator) }

      it 'list of users' do
        get :index
        expect(response).to render_template(:index)
      end
    end
  end

  describe 'PATCH #upgrade_role' do
    context 'guest' do
      it 'tries update role for user' do
        patch :upgrade_role, params: { id: record.id }
        record.reload
        expect(record.role).to eq('user')
      end

      it 'redirect to root_path' do
        patch :upgrade_role, params: { id: record.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'authenticated user' do
      before { login(user) }

      it 'tries update role for user' do
        patch :upgrade_role, params: { id: record.id }
        record.reload
        expect(record.role).to eq('user')
      end

      it 'redirect to root_path' do
        patch :upgrade_role, params: { id: record.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'moderator' do
      before { login(moderator) }

      it 'tries update role for user' do
        patch :upgrade_role, params: { id: record.id }
        record.reload
        expect(record.role).to eq('user')
      end

      it 'redirect to root_path' do
        patch :upgrade_role, params: { id: record.id }
        expect(response).to redirect_to root_path
      end
    end

    context 'admin' do
      before { login(admin) }

      it 'tries update role for user' do
        expect(record.role).to eq('user')
        patch :upgrade_role, params: { id: record.id }
        record.reload
        expect(record.role).to eq('moderator')
      end

      it 'redirect to user_path' do
        patch :upgrade_role, params: { id: record.id }
        expect(response).to redirect_to user_path(record.id)
      end
    end

    describe 'PATCH #downgrade_role' do
      let!(:record) { create(:user, role: 'moderator') }

      context 'guest' do
        it 'tries update role for user' do
          patch :downgrade_role, params: { id: record.id }
          record.reload
          expect(record.role).to eq('moderator')
        end

        it 'redirect to root_path' do
          patch :downgrade_role, params: { id: record.id }
          expect(response).to redirect_to root_path
        end
      end

      context 'authenticated user' do
        before { login(user) }

        it 'tries update role for user' do
          patch :downgrade_role, params: { id: record.id }
          record.reload
          expect(record.role).to eq('moderator')
        end

        it 'redirect to root_path' do
          patch :downgrade_role, params: { id: record.id }
          expect(response).to redirect_to root_path
        end
      end

      context 'moderator' do
        before { login(moderator) }

        it 'tries update role for user' do
          patch :downgrade_role, params: { id: record.id }
          record.reload
          expect(record.role).to eq('moderator')
        end

        it 'redirect to root_path' do
          patch :downgrade_role, params: { id: record.id }
          expect(response).to redirect_to root_path
        end
      end

      context 'admin' do
        before { login(admin) }

        it 'tries update role for user' do
          expect(record.role).to eq('moderator')
          patch :downgrade_role, params: { id: record.id }
          record.reload
          expect(record.role).to eq('user')
        end

        it 'redirect to user_path' do
          patch :downgrade_role, params: { id: record.id }
          expect(response).to redirect_to user_path(record.id)
        end
      end
    end
  end
end