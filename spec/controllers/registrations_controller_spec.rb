require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  describe "#new" do
    it "renders the new template and assigns a new user" do
      get :new

      expect(response).to render_template(:new)
      expect(assigns(:user)).to be_a_new(User)
    end
  end

  describe "#create" do
    context "with valid attributes" do
      let(:valid_attributes) do {
        user: {
          username: "username",
          password: "password",
          password_confirmation: "password" }
        }
      end

      it "creates a new user and sets the user session" do
        expect do 
          post :create, params: valid_attributes 
        end.to change(User, :count).by(1)
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects to root path with a success notice" do
        post :create, params: valid_attributes

        expect(response).to redirect_to(root_path)
        expect(flash[:notice]).to eq("Successfully created account")
      end
    end

    context "with invalid attributes" do
      let(:invalid_attributes) do {
        user: {
          username: "",
          password: "password",
          password_confirmation: "password"
          }
        }
      end

      it "renders new template and does not create a new user" do
        expect do 
          post :create, params: invalid_attributes 
        end.not_to change(User, :count)
        expect(response).to render_template(:new)
      end
    end
  end
end
