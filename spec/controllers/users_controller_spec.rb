require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe "GET #new" do
    it "renders a create user account page" do
      get :new

      expect(response).to render_template("new")
      expect(response).to have_http_status(200)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a user and redirects to the user's page" do
        params = {user: {username: "Victor", password: "password"}}
        post :create, params

        expect(session[session_token]).to_not be_nil
        expect(response).to redirect_to(user_url(User.last))
      end
    end

    context "with invalid params" do
      it "redirects to new user registration page" do
        post :create, {user: {username: "", password: ""}}

        expect(response).to redirect_to(new_user_url)
      end
    end
  end

  describe "GET #show" do
    it "renders the show page" do
      FactoryGirl.create(:user)
      get :show, id: 1

      expect(response).to render_template("show")
      expect(response).to have_http_status(200)
    end
  end

  describe "DELETE #destroy" do
    context "user is in the database" do
      it "destroys the user and redirects to user registration" do
        user = FactoryGirl.create(:user)
        delete :destroy, id: user.id

        expect(User.last).to be_nil
        expect(response).to redirect_to(new_user_url)
      end
    end

    context "user is not in the database" do
      it "redirects to user registration" do
        delete :destroy, id: -1

        expect(response).to redirect_to(new_user_url)
      end
    end
  end
end
