class EventLocationsController < ApplicationController
	before_action :find_event

	def new
		@location=@event.build_location
		#無法使用＠event.location.build
		#因為has_one是一個物件而不是一個類似陣列的物件
	end

	def show
		@location=@event.location
	end

	def edit
		@location = @event.location
	end

	def create
		@location=@event.build_location(location_params)
		if @location.save
			redirect_to event_location_path
		else
			render :action=>:new
		end
	end

	def update
		@location = @event.location

		if @location.update(location_params)
      redirect_to event_location_url( @event )
    else
      render :action => :show
    end
	end

	def destroy
  	@location = @event.location
    @location.destroy

		redirect_to event_location_url( @event )
	end
	private

	def location_params
		params.require(:location).permit(:name)
	end

	def find_event
		@event=Event.find(params[:event_id])
	end
end
