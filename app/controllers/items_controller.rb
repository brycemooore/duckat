class ItemsController < ApplicationController

    before_action :require_login, only: [:show, :new, :create, :edit, :update, :destroy]
    before_action :set_item, only: [:show, :edit, :update, :destroy]

    def index
        if params[:tag_sort].present?
            @items = Item.joins(:tags).where(tags: {name: params[:tag_sort]})
        else
            case params[:list]
            when "sale"
                @items = Item.where.not seller_id: current_user.id
            when "selling"
                @items = Item.where seller_id: current_user.id
            when "price h-l"
                @items = (Item.where.not seller_id: current_user.id).sort_by { |d| d.asking_price}.reverse
            when "price l-h"
                @items = (Item.where.not seller_id: current_user.id).sort_by { |d| d.asking_price}
            else
                @items = Item.all
            end
        end 
    end

    def show
        cookies[:last_visited_item_id] = @item.id
        @bid = Bid.new
    end

    def new
        @item = Item.new
        @item.tags.build
        @item.tags.build
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
        @item.update(item_params)
        redirect_to item_path(@item)
    end

    def destroy
        @item.delete
        redirect_to items_path
    end

    private 

    def set_item
        @item = Item.find(params[:id])
    end 

    def item_params
        params.require(:item).permit(
            :name, 
            :description,
            :seller_id,
            :asking_price,
            :end_date,
            :image,
            tags_attributes: [
                :name
            ]
        )
    end

    def require_login
        return head(:forbidden) unless logged_in?
    end
end
