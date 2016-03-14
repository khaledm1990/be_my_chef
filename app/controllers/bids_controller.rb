class BidsController < ApplicationController
	# only chef can create, delete bids & update price
	# only user can update deal
	before_filter :check_id, only: [:new, :create]
	before_filter :correct_bid, only: [:show, :edit, :update]
  before_filter :own_bid, only: :destroy

	def index
    @bids = current_user.bids.all
  end

  def show
  	@bid = Bid.find(params[:id])
  	@event = Event.find(@bid.event_id)
    @bid.messages.build
  end

  def new
    @bid = Bid.new
    @bid.messages.build
    @event = Event.find(params[:event_id])
  end

  def edit
  	@bid = Bid.find(params[:id])
    @bid.messages.build
  end

  def create
  	@event = Event.find(params[:event_id])
    @bid = current_user.bids.new(bid_params)
    @bid.messages.build if @bid.messages.count < 1

    respond_to do |format|
      if @bid.save
        format.html { redirect_to bid_path(@bid), notice: 'Bid was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @bid = Bid.find(params[:id])
    respond_to do |format|
      if @bid.update_attributes(bid_params)
        # @bid.messages.find(params[:id]).update_attributes(user_id: current_user.id) if @bid.messages
        format.html { redirect_to @bid, notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid}
      else
        format.html { render 'show' }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    bid = Bid.find(params[:id])
    bid.messages.each do |msg|
      msg.destroy
    end
    bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def check_id
    unless current_user.chef_status
      redirect_to events_path, notice: 'Only chef is allowed to bid!'
    end
  end

  def correct_bid
  	@bid = Bid.find(params[:id])
  	@event = Event.find(@bid.event_id)
    unless (current_user == @event.user) || (current_user == @bid.user)
      puts "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
      redirect_to events_path, notice: 'Forbidden site for strangers!'
    end
  end

  def own_bid
    @bid = Bid.find(params[:id])
    unless current_user == @bid.user
      redirect_to events_path, notice: 'Only bid creator can delete bid!'
    end
  end

  def bid_params
    if current_user.chef_status? && !@bid
      puts "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
    	params.require(:bid).permit(:price, :event_id, :messages_attributes=>[:id, :bid_id, :user_id, :content])
    elsif current_user == @event.user
      puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
		  params.require(:bid).permit(:deal, :messages_attributes=>[:id, :bid_id, :user_id, :content])
    elsif current_user == @bid.user
      params.require(:bid).permit(:price, :event_id, :messages_attributes=>[:id, :bid_id, :user_id, :content])
    else
      params.require(:bid).permit(:messages_attributes=>[:id, :bid_id, :user_id, :content])
    end
  end

end
