require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let!(:the_post) { create(:post, author: user) }

  before(:each) do
    allow(Current).to receive(:user).and_return(user)
  end

  describe "GET #index" do
    let(:another_post) { create(:post, author: user) }

    it "assigns and renders index template" do
      get :index

      expect(assigns(:posts)).to eq([the_post, another_post])
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "assigns and renders show template" do
      get :show, params: { id: the_post.id }

      expect(assigns(:post)).to eq(the_post)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "assigns and renders new template" do
      get :new

      expect(assigns(:post)).to be_a_new(Post)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) do
        { post: { title: "a title",
                  content: "a content",
                  author: user
          }
        }
      end

      it "creates and redirects to new post" do
        expect do
          post :create, params: valid_params
        end.to change(Post, :count).by(1)

        expect(flash[:notice]).to eq("Post was successfully created.")
        expect(response).to redirect_to(Post.last)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        { post: { title: "",
                  content: "",
                  author: user
          }
        }
      end

      it "does not create a new post and renders new template" do
        expect {
          post :create, params: invalid_params
        }.not_to change(Post, :count)

        expect(response).to render_template(:new)
      end
    end
  end
end
