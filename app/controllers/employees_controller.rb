class EmployeesController < ApplicationController

  before_action :validate_admin,    only: :index
  before_action :validate_employee, except: [:index, :show]

  def index
    @employee = Employee.where(approved: false) 
  end

  def new
    @employee = Employee.new
    @company = Company.all
    redirect_to error_path if current_user.employee
  end

  def create
    employee = Employee.new(emp_params)
    employee.user_id = current_user.id

    if employee.save
      flash[:success] = "Profile Saved Successfully!"
      redirect_to employee_path(employee.id)
    else
      flash[:danger] = "Something went wrong. Try again!"
      redirect_to new_employee_path
    end
  end

  def show
    @employee = Employee.find(params[:id])   
    unless  @employee == current_user.employee || current_user.admin?
      redirect_to error_path
    end
  end

  def edit
  end

  def destroy
  end

  private

  def emp_params
    params.require(:employee).permit(:name, :phone, :company_id,:user_id)
  end

end