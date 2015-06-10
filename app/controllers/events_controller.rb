class EventsController < ApplicationController
	#GET /events/index
	def index
		@events=Event.all
	end
	#GET /events/show
	def show
		@event=Event.find(params[:id])
	end
	#GET /events/new
	def new
		@event=Event.new
	end
	#GET /events/edit
	def edit
		@event=Event.find(params[:id])
	end
	#GET /events/destory/:id
	def destroy
		@event = Event.find(params[:id])
		@event.destroy
		redirect_to :action=>:index
	end
	#POST /events/creat
	def create
		@event=Event.new(event_params)
		@event.save
		redirect_to :action=>:index#重新導向
	end
	#POST /events/edit/:id
	def update
		@event = Event.find(params[:id])
		@event.update(event_params)
		redirect_to :action=>:show,:id=>@event
	end
	private
	#因為在ＲＵＢＹ中要求要送進去裡面的值都要先經過過濾
	def event_params
		#要求只用者只可以使用特定的欄位
		params.require(:event).permit(:name,:description)
	end
end
