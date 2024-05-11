class TimeEntriesController < ApplicationController
  def index
    http_response = HTTParty.get("https://api.harvestapp.com/v2/time_entries", headers: @current_user[:headers])
    @entries = http_response["time_entries"].take(20)
  end

  def new
    @tebc = TimeEntryBulkCreator.new
    @projects = Projects.new.get(@current_user[:headers])
  end

  def create
    @tebc = TimeEntryBulkCreator.new(tebc_params)
    result = @tebc.send(@current_user)

    if result
      redirect_to root_path, notice: result
    else
      @projects = Projects.new.get(@current_user[:headers])
      render :new, status: :unprocessable_entity
    end
  end

  private

  def tebc_params
    params.require(:time_entry_bulk_creator)
      .permit(:start_date, :end_date, :start_time, :end_time, :project_id, :task_id)
  end
end
