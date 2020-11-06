class ItemsController < ApplicationController
    def index
        case params[:list]
        when "sale"
            @items = Item.where.not seller_id: current_user.id
        when "selling"
            @items = Item.where seller_id: current_user.id
        else
            @items = Item.all
        end
    end

    def show
        @item = Item.find(params[:id])
        @bid = Bid.new
    end

    def new
        @item = Item.new
    end

    def create
        @item = Item.new(item_params)
        if @item.save
            redirect_to item_path(@item)
        else
            render :new
        end
    end

    def edit
        @item = Item.find(params[:id])
    end

    def update
        @item = Item.find(params[:id])
        @item.update(item_params)
        redirect_to item_path(@item)
    end

    def destroy
    end

    private 

    def item_params
        params.require(:item).permit(
            :name, 
            :description,
            :seller_id,
            :asking_price,
            :end_date
        )
    end
end
