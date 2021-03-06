require 'spec_helper'

describe "Authentication" do

	subject { page }

  describe "signin page" do
    before { visit signin_path }

    it { should have_content('Sign in') }
    it { should have_title('Sign in') }
    it { should_not have_link('Facilities') }
    it { should_not have_link('Samples') }
    it { should_not have_link('Reports') }
    it { should_not have_link('Sign out') }
  end

  describe "signin" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }

      it { should have_title('Sign in') }
      it { should have_selector('div.alert.alert-error') }
    end

    describe "with valid information" do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in user }

      it { should have_title('MDH EQA') }
      it { should have_link('Sign out',    href: signout_path) }
      it { should_not have_link('Sign in', href: signin_path) }
      it { should have_link('Facilities') }
      it { should have_link('Samples') }
      it { should have_link('Reports') }

      describe "followed by signout" do
        before { click_link "Sign out" }
        it { should_not have_link('Sign out') }
      end
    end
  end

  describe "authorization" do

    describe "for non-signed-in users" do
      let(:user) { FactoryGirl.create(:user) }

      describe "in the Demo Pages controller" do

        describe "visiting the home page" do
          before { visit demo_path }
          it { should have_title('Sign in') }
        end
      end
    end

  end

end
