module BidsHelper

	def close_event(event)
		bids = Bid.where(event_id: event.id, deal: true)
		if bids.count > 0
			event.closed = true
			event.save
		end
	end

end
