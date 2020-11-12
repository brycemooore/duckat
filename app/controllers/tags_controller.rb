class TagsController < ApplicationController

    def new
        @tag = Tag.new
        @item = Item.find(params[:item_id])
    end

    def create
        @tag = Tag.find_or_initialize_by(tag_params)
        @tag.save
        ItemTag.create(tag_id: @tag.id, item_id: cookies[:last_visited_item_id])
        redirect_to item_path(cookies[:last_visited_item_id])
    end

    private 
    def tag_params
        params.require(:tag).permit(:name)
    end 
end
