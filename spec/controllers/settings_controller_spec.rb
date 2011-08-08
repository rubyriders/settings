require 'spec_helper'

describe SettingsController, 'GET index' do
  render_views
  before(:each) do
    @settings = Setting.all
  end
  
  it "should list settings" do
    get :index
    assigns[:settings].should eq(@settings)
  end
  
  it "should respond with success" do
    get :index
    response.should be_success
  end
  
  it "should render template index" do
    get :index
    response.should render_template(:index)
  end
end

describe SettingsController, 'GET new' do
  render_views
  
  it "should assign setting" do
    get :new
    assigns[:setting].new_record?.should eq(true)
  end
  
  it "should respond with success" do
    get :new
    response.should be_success
  end
  
  it "should render template index" do
    get :new
    response.should render_template(:new)
  end
end

describe SettingsController, 'POST create with valid params' do
  render_views
  
  before(:each) do
    post :create, :setting => { :name => 'setting_name', :value => 123 }
  end
  
  it "should assign setting params" do
    assigns[:setting].name.should eq('setting_name')
    assigns[:setting].value.should eq(123)
  end
  
  it "should respond with success" do
    response.should be_redirect
  end
  
  it "should redirect to settings index" do
    response.should redirect_to(settings_path)
  end
end

describe SettingsController, 'POST create with invalid params' do
  render_views
  
  before(:each) do
    post :create, :setting => { :name => nil, :value => 123 }
  end
  
  it "should assign setting params" do
    assigns[:setting].name.should eq(nil)
    assigns[:setting].value.should eq(123)
  end
  
  it "should have invalid setting assigned" do
    assigns[:setting].valid?.should eq(false)
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "should render template new" do
    response.should render_template(:new)
  end
end


describe SettingsController, 'GET show' do
  render_views
  
  before(:each) do
    @setting = Setting.create!(:name => 'test', :value => 'test')
    get :show, :id => @setting.id
  end
  
  it "should assign setting" do
    assigns[:setting].should eq(@setting)
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "should render template index" do
    response.should render_template(:show)
  end
end

describe SettingsController, 'GET edit' do
  render_views
  
  before(:each) do
    @setting = Setting.create!(:name => 'test', :value => 'test')
    get :edit, :id => @setting.id
  end
  
  it "should assign setting" do
    assigns[:setting].should eq(@setting)
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "should render template index" do
    response.should render_template(:edit)
  end
end

describe SettingsController, 'PUT update with valid params' do
  render_views
  
  before(:each) do
    @setting = Setting.create!(:name => 'test', :value => 'test')
    put :update, :id => @setting.id, :setting => { :name => 'new', :value => 123 }
  end
  
  it "should assign new setting params" do
    assigns[:setting].name.should eq('new')
    assigns[:setting].value.should eq(123)
    assigns[:setting].valid?.should eq(true)
  end
  
  it "should respond with success" do
    response.should be_redirect
  end
  
  it "should redirect to index" do
    response.should redirect_to(settings_path)
  end
end

describe SettingsController, 'PUT update with invalid params' do
  render_views
  
  before(:each) do
    @setting = Setting.create!(:name => 'test', :value => 'test')
    put :update, :id => @setting.id, :setting => { :name => nil, :value => 123 }
  end
  
  it "should assign new setting params" do
    assigns[:setting].name.should eq(nil)
    assigns[:setting].value.should eq(123)
    assigns[:setting].valid?.should eq(false)
  end
  
  it "should respond with success" do
    response.should be_success
  end
  
  it "should redirect to index" do
    response.should render_template(:edit)
  end
end