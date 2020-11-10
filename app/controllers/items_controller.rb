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
            else
                @items = Item.all
            end
        end 
    end

    def show
        @bid = Bid.new
    end

    def new
        @item = Item.new
        @item.tags.build
        @item.tags.build
    end

    def create
        # byebug
        @item = Item.new(item_params)
        item_params[:tags_attributes].each do |key, value|
            @item.tags << Tag.find_or_initialize_by(name: value["name"])
        end 
        if @item.save
            redirect_to item_path(@item)
        else
            render :new
        end
    end

    def edit
    end

    def update
        item_params[:tags_attributes].each do |tag|
            @item.tags << Tag.find_or_initialize_by(item_params[:tag_attributes])
        end 
        if @item.update(item_params)
            redirect_to item_path(@item)
        else 
            render :edit
        end 
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
