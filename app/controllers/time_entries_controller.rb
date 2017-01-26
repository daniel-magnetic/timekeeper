class TimeEntriesController < ApplicationController
  before_action :set_time_entry, only: [:show, :update, :destroy]

  # GET /time_entries
  def index
    @time_entries = TimeEntry.all

    render json: @time_entries
  end

  # GET /time_entries/1
  def show
    render json: @time_entry
  end

  # POST /time_entries
  def create
    @time_entry = TimeEntry.new(time_entry_params)

    if @time_entry.save
      render json: @time_entry, status: :created, location: @time_entry
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /time_entries/1
  def update
    if @time_entry.update(time_entry_params)
      render json: @time_entry
    else
      render json: @time_entry.errors, status: :unprocessable_entity
    end
  end

  # DELETE /time_entries/1
  def destroy
    @time_entry.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_time_entry
      @time_entry = TimeEntry.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def time_entry_params
      params.require(:time_entry).permit(:timecard_id, :time)
    end
end
