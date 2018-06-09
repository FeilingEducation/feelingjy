class DepartmentsController < ApplicationController

  def show
    @department = Department.find(params[:id])
  end
end
