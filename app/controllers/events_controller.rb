class EventsController < ApplicationController
	before_action :set_event,:only =>[:show,:edit,:update,:destroy]
	#GET /events/index
	def index
		@events = Event.page(params[:page]).per(5)
						#model
		respond_to do |format|
			format.html #index.html.erb
			format.xml {
				render :xml=>@events.to_xml
				#直接用後面資料產生資料
			}
			format.json {
				render :json=>@events.to_json
			}
			format.atom {
				@feed_title ="My event list "
			}#index.atom.builder
		end
		# @events=Event.all
	end
	#GET /events/show
	def show
		respond_to do |format|
			format.html #index.html.erb
			format.xml
			format.json {
				render :json=>{id:@event.id,name:@event.name}.to_json
				#可以自己指定欄位或是位置
			}
			format.atom {
				@feed_title ="My event list "
			}#index.atom.builder
		end
		# @event=Event.find(params[:id])
	end
	#GET /events/new
	def new
		@event=Event.new
	end
	#GET /events/edit
	def edit
	end
	#GET /events/destory/:id
	def destroy
		@event.destroy
		flash[:notice] = "event was successfully updated"
		redirect_to events_path
	end
	#POST /events/creat
	def create
		@event=Event.new(event_params)
		if @event.save
			flash[:notice] = "event was successfully created"
			redirect_to events_path#重新導向
		else
			#讓使用者可以直接知道錯誤 不用再填一次
			render :action=>:new
		end
	end
	#POST /events/edit/:id
	def update
		if @event.update(event_params)
			flash[:notice] = "event was successfully updated"
			redirect_to event_path(@event)
		else
			render :action=>:edit
		end
	end
	private
	def set_event
		@event = Event.find(params[:id])
	end
	#因為在ＲＵＢＹ中要求要送進去裡面的值都要先經過過濾
	def event_params
		#要求只用者只可以使用特定的欄位
		params.require(:event).permit(:name,:description)
	end
end
