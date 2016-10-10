require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe "GET #new" do
    it "renders sign in page" do
      get :new
      expect(response).to render_template(:new)
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "logs a user in and redirects to the user's page" do
        user = FactoryGirl.create(:user, username: "Victor", password: "password")
        params = {user: {username: "Victor", password: "password"}}
        post :create, params

        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "redirects to log-in page" do
        post :create, {user: {username: "", password: ""}}

        expect(response).to redirect_to(new_session_url)
      end
    end
  end

  describe "DELETE #destroy" do
    context "user is logged in" do
      it "logs out and redirects to user log-in" do
        user = FactoryGirl.create(:user)
        delete :destroy

        expect(session[:session_token]).to be_nil
        expect(response).to redirect_to(new_session_url)
      end
    end

    context "user is logged out" do
      it "redirects to user registration" do
        delete :destroy

        expect(response).to redirect_to(new_session_url)
      end
    end
  end

end
