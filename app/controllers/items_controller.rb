class ItemsController < ApplicationController
    def index
        @items = Item.all
    end

    def show
        @item = Item.find(params[:id])
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
    end

    def update
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