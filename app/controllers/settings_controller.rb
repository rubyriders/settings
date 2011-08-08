class SettingsController < ApplicationController
  def index
    @settings = Setting.all
  end
  
  def show
    @setting = Setting.find params[:id]
  end
  
  def new
    @setting = Setting.new
  end
  
  def create
    @setting = Setting.new params[:setting]
    if @setting.save
      redirect_to settings_path
    else
      render :action => 'new'
    end
  end
  
  def edit
    @setting = Setting.find params[:id]
  end
  
  def update
    @setting = Setting.find params[:id]
    if @setting.update_attributes params[:setting]
      redirect_to settings_path
    else
      render :action => 'edit'
    end
  end
  
end
