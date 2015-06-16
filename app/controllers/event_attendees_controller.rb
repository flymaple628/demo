class EventAttendeesController < ApplicationController
	before_action :event_find
	def index
		@attendees=@event.attendees
	end

	def show
		@attendee=@event.attendees.find( params[:id])
	end

	def new
		@attendee=@event.attendees.build
	end

	def create
		@attendee=@event.attendees.build(attendee_params)
		if @attendee.save
			redirect_to event_attendees_url(@event)
		else
			render :action=>:new
		end
	end
	def edit
		@attendee=@event.attendees.find( params[:id])
	end
	def update
		@attendee=@event.attendees.find( params[:id])
		if @attendee.update(attendee_params)
			redirect_to event_attendees_url(@event)
		else
			render :action=>:edit
		end
	end
	def destroy
		@attendee=@event.attendees.find( params[:id])
		@attendee.destroy

		redirect_to event_attendees_path
	end
	private

	def attendee_params
		params.require(:attendee).permit(:name)
	end

	def event_find
		@event=Event.find(params[:event_id])
	end
end
