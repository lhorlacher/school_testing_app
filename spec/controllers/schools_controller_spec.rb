require 'rails_helper'

RSpec.describe SchoolsController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it "sets the schools instance variable" do
      get :index
      expect(assigns(:schools)).to eq([])
    end

    it "has schools in the instance variable" do
      School.create(name: 'test_school', rating: 7, level: 'high')
      get :index
      expect(assigns(:schools).length).to eq(1)
      expect(assigns(:schools).first.name).to eq('test_school')
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      get :show, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      get :show, id: school.id
      expect(assigns(:school)).to eq(school)
    end

    it "renders the show template" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      get :show, id: school.id
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      get :new
      expect(assigns(:school)).to_not eq(nil)
      expect(assigns(:school).class).to eq(School)
    end

    it "returns the new template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    it "successfully creates a school" do
      school_params = {school: {name: 'test_school', rating: 7, level: 'elementary'} }
      post :create, school_params
      expect(School.count).to eq(1)
      expect(School.first.name).to eq(school_params[:school][:name])
    end

    it "redirects to the school path on success" do
      school_params = {school: {name: 'test_school', rating: 7, level: 'elementary'} }
      post :create, school_params
      expect(response).to redirect_to school_path(School.first)
    end

    it "renders the edit page on failure" do
      school_params = {school: {name: '', rating: 7, level: 'elementary'} }
      post :create, school_params
      expect(response).to render_template(:new)
    end

  end

  describe "GET #edit" do
    it "returns http success" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      get :edit, id: school.id
      expect(response).to have_http_status(:success)
    end

    it "sets the school instance variable" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      get :edit, id: school.id
      expect(assigns(:school)).to eq(school)
    end

    it "renders the edit template" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      get :edit, id: school.id
      expect(response).to render_template(:edit)
    end
  end


  describe "PUT #update" do
    it "successfully updates a school" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      school_params = {name: "updated"}
      put :update, {id: school.id, school: school_params}
      expect(School.first.name).to eq('updated')
    end

    it "redirects to the school path on successful update" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      school_params = {name: "updated"}
      put :update, {id: school.id, school: school_params}
      expect(response).to redirect_to school_path(School.first)
    end

    it "renders the edit page on failed update" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      school_params = {name: ""}
      put :update, {id: school.id, school: school_params}
      expect(response).to render_template(:edit)
    end
  end

  describe "DELETE #destroy" do
    it "successfully deletes a school" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      delete :destroy, id: school.id
      expect(School.first).to eq(nil)
    end

    it "redirects to the schools path on success" do
      school = School.create(name: 'test_school', rating: 7, level: 'high')
      delete :destroy, id: school.id
      expect(response).to redirect_to schools_path
    end
  end
end
