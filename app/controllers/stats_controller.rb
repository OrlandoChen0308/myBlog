class StatsController < ApplicationController
  #   def set_stat
  #     @stat = Stat.find(params[:id])
  #   end	
  # before_action :set_event, only: [:update]

  def stat_params
    params.require(:stat).permit(:status)
  end

  def update
    @stat = Stat.find(params[:id])

    respond_to do |format|
      if @stat.update(stat_params)
        format.html { redirect_to @stat.event, notice: 'Event status was successfully updated.' }
        # format.json { render :show, status: :ok, location: @event }
      else
        redirect_to @stat.event
        # format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

end

