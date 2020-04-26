class CommentsController < ApplicationController

    #TODO: INDEX method (or INDEX action) 04/21/2020
    def index
        # if params.dig(:comment,:user_id).nil? == false
        #     comments = Comment.where(user_id: params[:comment][:user_id])
        #     render json: comments
        # elsif
        #     params.dig(:comment,:artwork_id).nil? == false
        #     comments = Comment.where(artwork_id: params[:comment][:artwork_id])
        #     render json: comments
        # else
        #     render json: Comment.all
        # end
        case
        when params[:user_id]
            comments = Comment.where(user_id: params[:user_id])
        when params[:artwork_id]
            comments = Comment.where(artwork_id: params[:artwork_id])
        else
            comments = Comment.all
        end
        render json: comments
    end

    def create
        comment = Comment.new(comment_params)
        if comment.save
            render json: comment
        else
            render json :comment.errors.full_messages, status: :unprocessable_entity
        end
    end

    def destroy
        comment = Comment.destroy(params[:id])
        render json: comment
    end

    private
    def comment_params
        params.require(:comment).permit(:user_id,:artwork_id,:text)
    end
end