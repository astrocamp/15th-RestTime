class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create

      shop = Shop.find(params[:shop_id])
      
      comment = shop.comments.new(comment_params)
        
      if comment.save
        redirect_to shop_path(shop), notice: '新增留言成功'
      else
        redirect_to shop_path(shop), alert: '留言發生錯誤'
      end
    end
  
    def destroy
        @comment = Comment.find(params[:id])
        @shop = @comment.shop
        
        if @comment.destroy
          redirect_to shop_path(@shop), notice: '評論已成功刪除'
        else
          redirect_to shop_path(@shop), alert: '無法刪除評論'
        end
      end

    # def show
    #     @comment = Comment.find(params[:id])
    # end
    private
  
    def comment_params
      params.require(:comment)
            .permit(:content)
            .merge(user: current_user)
    end
  
end
