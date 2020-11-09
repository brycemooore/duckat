class BidsController < ApplicationController
  def index
    @bids = Bid.where user_id: current_user.id
  end

  def show
    @bid = Bid.find(params[:id])
    @item = Item.find @bid.item_id

  end

  def new
    @bid = Bid.new
    @item = Item.find(params[:item_id])
  end

  def create
    @bid = Bid.new(bid_params)
    if @bid.save
      redirect_to bid_path(@bid)
    else
      redirect_to new_bid_path(item_id: @bid.item_id)
    end
  end

  def find_max_bid(item)
    self.bids.where(item_id: item.id).maximum(:bid_amount)
  end

  private

  def bid_params
    params.require(:bid).permit(:user_id, :item_id, :bid_amount)
  end

end
