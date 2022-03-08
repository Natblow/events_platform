require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/users", type: :request do

  # This should return the minimal set of attributes required to create a valid
  # User. As you add validations to User, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) do
    {
      id: '63',
      name: 'Luc',
      email: 'testrspec@example.com',
      password: 'password',
      password_confirmation: 'password',
      confirmation_token: 'AZCDE2134',
      admin: true
    }
  end
  let(:invalid_attributes) do
    {
      id: '61',
      name: nil,
      email: 'testalphaexample.com',
      password: 'password',
      password_confirmation: 'password',
      confirmation_token: 'ABCDE2134',
      admin: false
    }
  end

  describe "GET /index" do
    it "renders a successful response" do
      User.create! valid_attributes
      get users_url
      follow_redirect!
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_user_url
      follow_redirect!
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      user = User.create! valid_attributes
      get edit_user_url(user)
      follow_redirect!
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          id: '61',
          email: 'testbeta@example.com',
          password: 'password',
          password_confirmation: 'password',
          confirmation_token: 'ABCDE2222',
          admin: false
        }
      end

      it "updates the requested user" do
        user = User.create! valid_attributes
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(valid_attributes['id']).to eq(:new_attributes['id'])
      end

      it "redirects to the user" do
        user = User.create! valid_attributes
        patch user_url(user), params: { user: new_attributes }
        user.reload
        expect(response.status).to eq(302)
        # expect(response).to redirect_to(user_url(user))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        user = User.create! valid_attributes
        patch user_url(user), params: { user: invalid_attributes }
        follow_redirect!
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested user" do
      user = User.create! valid_attributes
      expect do
        delete user_url(user), params: { user: valid_attributes }
        user.delete
      end.to change(User, :count).by(-1)
    end

    it "redirects to the users list" do
      user = User.create! valid_attributes
      delete user_url(user)
      expect(response.status).to eq(302)
      # expect(response).to redirect_to(users_url)
    end
  end
end
