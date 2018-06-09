class DepartmentsController < ApplicationController

  def show
    @department = Department.friendly.find(params[:id])
  end
end
