require 'rails_helper'

RSpec.describe CountriesController, type: :controller do
  let(:country) { Country.create(name: 'Some Name', population: '10', language: 'English') }
  let(:user) { FactoryGirl.create(:user) }

  before(:each) do
    sign_in user
  end

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end

    it 'sets the countries instance variable' do
      get :index
      expect(assigns(:countries)).to eq([])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end

    it 'has countries in the countries instance variable' do
      3.times do |index|
        Country.create(
          name: "name_#{index}",
          population: '10',
          language: 'English'
        )
      end
      get :index
      expect(assigns(:countries).length).to eq(2)
      expect(assigns(:countries).last.name).to eq('name_1')
    end
  end

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "Sets the new instance variable" do
      get :new
      expect(assigns(:country)).to_not eq(nil)
      expect(assigns(:country).id).to eq(nil)
    end

  end

  describe "POST #create" do
    before(:all) do
      @country_params = {
        country: {
          name: 'Test Country',
          population: '10',
          language: 'English'
        }
      }
    end


    it "sets the country instance variable" do
      post :create, @country_params
      expect(assigns(:country)).to_not eq(nil)
      expect(assigns(:country).name).to eq(@country_params[:country][:name])
    end

    it "creates a new country" do
      expect(Country.count).to eq(0)
      post :create, @country_params
      expect(Country.count).to eq(1)
      expect(Country.first.name).to eq(@country_params[:country][:name])
    end
  end

  describe 'DELETE #destroy' do
    it 'sets the country instance variable' do
      delete :destroy, id: country.id
      expect(assigns(:country)).to eq(country)
    end

    it 'destroys the country' do
      country
      expect(Country.count).to eq(1)
      delete :destroy, id: country.id
      expect(Country.count).to eq(0)
    end

    it 'sets the flash message' do
      delete :destroy, id: country.id
      expect(flash[:success]).to eq("Country deleted!")
    end

    it 'redirect to index path after destroy' do
      delete :destroy, id: country.id
      expect(response).to redirect_to(countries_path)
    end
  end

  describe "GET #show" do
    it "returns http success" do
      get :show, id: country.id
      expect(response).to have_http_status(:success)
    end

    it "renders the show template" do
      get :show, id: country.id
      expect(response).to render_template(:show)
    end

    it "set the country instance variable" do
      get :show, id: country.id
      expect(assigns(:country).name).to eq(country.name)
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      get :edit, id: country.id
      expect(response).to have_http_status(:success)
    end

    it "renders edit template" do
      get :edit, id: country.id
      expect(response).to render_template(:edit)
    end

    it "sets country instance variable" do
      get :edit, id: country.id
      expect(assigns(:country).id).to eq(country.id)
    end
  end

  describe 'PUT #update' do
    it "sets the country instance variable" do
      put :update, { id: country.id, country: { name: 'new name' }}
      expect(assigns(:country).id).to eq(country.id)
    end

    it "updates the country" do
      put :update, { id: country.id, country: { name: 'new name' }}
      expect(country.reload.name).to eq('new name')
    end

    it 'sets a flash message on success' do
      put :update, { id: country.id, country: { name: 'new name' }}
      expect(flash[:success]).to eq('Country Updated!')
    end

    it 'redirects to show on success' do
      put :update, { id: country.id, country: { name: 'new name' }}
      expect(response).to redirect_to(country_path(country.id))
    end

    describe 'update failures' do
      before(:each) do
        Country.create(name: 'bar', population: '30000', language: 'Spanish')
      end

      it 'renders edit on fail' do
        put :update, { id: country.id, country: { name: 'bar', population: '30'} }
        expect(response).to render_template(:edit)
      end

      it 'sets flash message on error' do
        put :update, { id: country.id, country: { name: 'bar', population: '30' } }
        expect(flash[:error]).to eq('Country failed to update')
      end

    end
  end
end
