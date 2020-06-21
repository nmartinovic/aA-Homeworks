require 'rails_helper'

RSpec.describe UsersController, type: :controller do

    describe "GET #new" do
        it "returns the new template" do
            get :new
            expect(response).to render_template("new")
        end
    end

    describe "POST #create" do
        it "directs to user page if passed proper params" do
            post :create, {params: {user: {email: 'routetest', password:'routetest'}}}
            expect(response).to redirect_to(user_url(User.last)) 
            expect(response).to have_http_status(302)
        end


        it "renders new template with errors if passed incorrect params" do
            post :create, {params: {user: {email: 'routetest', password:''}}}
            expect(response).to render_template("new")
            expect(flash[:errors]).to be_present
        end
    end

    describe "GET #show" do
        it "gets the show template" do
            get :show, {params: {id: 1}}
            expect(response).to render_template("show")
        end
    end
end
