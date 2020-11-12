class CommentsController < ApplicationController

    def new
        @comment = Comment.new
        @item = Item.find(params[:item_id])
    end

    def create
        @comment = Comment.create(comment_params)
        redirect_to item_path(Item.find(@comment.item_id))
    end 

    private
    def comment_params
        params.require(:comment).permit(:user_id, :item_id, :message)
    end 
end
