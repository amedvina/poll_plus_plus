require "rails_helper"

RSpec.describe PollsController, type: :controller do
  let(:user) { create(:user) }
  let!(:poll) { create(:poll, author_id: user.id) }

  describe "#index" do
    context "when user is signed in" do
      it "renders the index template and and assigns all polls" do
        allow(Current).to receive(:user).and_return(user)
        get :index
        
        expect(response).to have_http_status(:success)
        expect(response).to render_template(:index)
        expect(assigns(:polls)).to eq(Poll.all)
      end
    end

    context "when user is not signed in" do
      it "redirects to sign in path" do
        get :index

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "#show" do
    context "when user is signed in" do
      it "renders the show template and correctly assigns" do
        allow(Current).to receive(:user).and_return(user)
        get :show, params: { id: poll.id }

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:show)
        expect(assigns(:poll)).to eq(poll)
        expect(assigns(:author)).to eq(poll.author_id)
        expect(assigns(:new_vote)).to be_a_new(Vote)
        expect(assigns(:result)).to be_a(Polls::Result)
        expect(assigns(:final_result)).to eq(Polls::Result.new(poll).final_result)
      end
    end

    context "user not signed in" do
      it "redirects to sign in path" do
        get :show, params: { id: poll.id }

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "#new" do
    context "when user is signed in" do
      it "renders the new template and correctly assigns a new poll" do
        allow(Current).to receive(:user).and_return(user)
        get :new

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:new)
        expect(assigns(:poll)).to be_a_new(Poll)
      end
    end

    context "user not signed in" do
      it "redirects to sign in path" do
        get :show, params: { id: poll.id }

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "#create" do
    context "when user is signed in" do
      context "with valid parameters" do
        it "creates a new poll and redirects to the show page" do
          allow(Current).to receive(:user).and_return(user)

          expect do
            post :create, params: { poll: { title: "Poll Title", start_time: Date.today, end_time: Date.tomorrow } }
          end.to change(Poll, :count).by(1)
          expect(response).to redirect_to(Poll.last)
        end
      end

      context "with invalid parameters" do
        it "does not create a new poll and renders the new template" do
          allow(Current).to receive(:user).and_return(user)

          expect do
            post :create, params: { poll: { title: nil, start_time: Date.today, end_time: Date.tomorrow } }
          end.not_to change(Poll, :count)
          expect(response).to render_template(:new)
        end
      end
    end

    context "user not signed in" do
      it "does not create a new poll and redirects to sign in path" do
        expect do
          post :create, params: { poll: { title: "Poll Title", start_time: Date.today, end_time: Date.tomorrow } }
        end.to change(Poll, :count).by(0)
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "#edit" do
    context "when user is signed in" do
      it "renders the edit template" do
        allow(Current).to receive(:user).and_return(user)
        get :edit, params: { id: poll.id }

        expect(response).to have_http_status(:success)
        expect(response).to render_template(:edit)
      end
    end

    context "user not signed in" do
      it "redirects to sign in path" do
        get :edit, params: { id: poll.id }

        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "#update" do  
    context "when user is signed in" do
      context "with valid attributes" do
        it "updates the poll" do
          allow(Current).to receive(:user).and_return(user)
          put :update, params: { id: poll.id, poll: attributes_for(:poll, title: "Updated title") }
          poll.reload

          expect(poll.title).to eq("Updated title")
          expect(response).to redirect_to(poll)
        end
      end
    
      context "with invalid attributes" do
        it "does not update the poll and redirects" do
          allow(Current).to receive(:user).and_return(user)
          put :update, params: { id: poll.id, poll: attributes_for(:poll, title: nil) }
          poll.reload

          expect(poll.title).not_to be_nil
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response).to render_template(:edit)
        end
      end
    end

    context "user is not signed in" do
      it "does not update the poll and redirects to sign in path" do
        put :update, params: { id: poll.id, poll: attributes_for(:poll, title: "Updated title") }
        poll.reload

        expect(poll.title).to_not eq("Updated title")
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "#destroy" do  
    context "when user is signed in" do
      it "destroys the poll" do
        allow(Current).to receive(:user).and_return(user)

        expect do
          delete :destroy, params: { id: poll.id }
        end.to change(Poll, :count).by(-1) 
        expect(response).to have_http_status(:see_other)
      end
    end

    context "user is not signed in" do
      it "does not destroy the poll and redirects to sign in path" do
        expect do
          delete :destroy, params: { id: poll.id }
        end.to change(Poll, :count).by(0)
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end
end
