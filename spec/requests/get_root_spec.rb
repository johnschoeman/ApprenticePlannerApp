require "rails_helper"
require "support/features/clearance_helpers"

RSpec.describe "GET /" do
  context "user is logged in" do
    it "renders the users home page" do
      user = create(:user, password: 'password')

      post session_path, params: { session: { email: user.email, password: 'password' } }
      follow_redirect!
      get root_path
      expect(response.body).to include "Home Page"
    end
  end

  context "user is not logged in" do
    it "redirects to the sign in page" do
      get root_path

      expect(response.body).to redirect_to(sign_in_url)
    end
  end
end
