class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :correct_event, only: [:edit, :update, :destroy]
  before_action :is_chef?, only: :all

  def all
    @events = Event.all - current_user.events.all - 
              Event.joins(:bids).where("bids.user_id = ?", current_user.id) - 
              Event.where(closed: true).all
  end

  # GET /events
  # GET /events.json
  def index
    @user = current_user
    @events = current_user.events.all
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
    @event.build_location
  end

  # GET /events/1/edit
  def edit
    @event.build_location if @event.location.nil?
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    event = Event.find(params[:id])
    event.bids.each do |bid|
      if bid.messages.count > 0
        bid.messages.each do |msg|
          msg.destroy
        end
      end
      bid.destroy
    end
    event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    
    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:name, :user_id, :date, :start_time,
                                    :end_time, :pax, :variety, :description,
                                    :location_attributes=>[:event_id, :block, :street, :city, :state, :postal_code]
                                    )
    end

    def correct_event
      @event = Event.find(params[:id])
      redirect_to events_path, notice: "Unauthorized site" unless current_user.id == @event.user_id
    end


    def is_chef?
      redirect_to events_path, notice: "Only chefs are allowed to view others' events" unless current_user.chef_status 
    end

end
