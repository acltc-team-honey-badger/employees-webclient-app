class EmployeesController < ApplicationController

  def index
    @employees = Employee.all
  end

  def show
    @employee = Employee.find(params[:id])
  end

  def new
  end

  def create
    @employee = Employee.create(first_name: params[:first_name], last_name: params[:last_name], birthdate: params[:birthdate], email: params[:email], ssn: params[:ssn])
    redirect_to "/employees/#{@employee.id}"
  end

  def edit
    @employee = Employee.find(params[:id])
  end

  def update
    @employee = Employee.find(params[:id])
    @employee.update(first_name: params[:first_name], last_name: params[:last_name], birthdate: params[:birthdate], email: params[:email], ssn: params[:ssn])
    redirect_to "/employees/#{@employee.id}"
  end

  def destroy
    @employee = Employee.find(params[:id])
    @employee.destroy
    redirect_to "/employees"
  end


end
