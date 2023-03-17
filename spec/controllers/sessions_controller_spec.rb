require "rails_helper"

RSpec.describe SessionsController, type: :controller do
	let(:user) { create(:user) }

	describe "#new" do
    it "renders the new template" do
      get :new

			expect(response).to have_http_status(:success)
      expect(response).to render_template(:new)
    end
  end

	describe "#create" do
    context "with valid credentials" do
			it "redirects to the root paths with a success message notice" do
				post :create, params: { username: user.username, password: user.password }
	
				expect(response).to redirect_to(root_path)
				expect(flash[:notice]).to eq("Logged in successfully")
			end
		end
	
		context "with invalid credentials" do
			it "renders the new template with an error message alert" do
				post :create, params: { username: "wrong_username", password: "wrong_password" }
	
				expect(response).to render_template(:new)
				expect(flash[:alert]).to eq("Invalid username or password")
			end
		end
  end
end
