class TimecardsController < ApplicationController
  before_action :set_timecard, only: [:show, :update, :destroy]

  # GET /timecards
  def index
    @timecards = Timecard.all

    render json: @timecards
  end

  # GET /timecards/1
  def show
    render json: @timecard
  end

  # POST /timecards
  def create
    @timecard = Timecard.new(timecard_params)

    if @timecard.save
      render json: @timecard, status: :created, location: @timecard
    else
      render json: @timecard.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /timecards/1
  def update
    if @timecard.update(timecard_params)
      render json: @timecard
    else
      render json: @timecard.errors, status: :unprocessable_entity
    end
  end

  # DELETE /timecards/1
  def destroy
    @timecard.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timecard
      @timecard = Timecard.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def timecard_params
      params.require(:timecard).permit(:username, :occurrence)
    end
end
