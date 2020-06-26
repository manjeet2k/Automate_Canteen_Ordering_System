class AdminsController < ApplicationController

  before_action :validate_admin
  
  def dashboard
  end

  def approve_employee
    @user = Employee.find(params[:id])
    approve_user
    redirect_to employees_path
  end

  def approve_chef
    @user = Chef.find(params[:id])
    approve_user
    redirect_to chefs_path
  end

  private

  def approve_user
    @user.approved = true
    if @user.save
      flash[:success] = "#{@user.name} approved!"
    else
      flash[:danger] = "#{@user.name} approval failure"
    end
  end


end