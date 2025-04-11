class FeedsController < ApplicationController
  before_action :authenticate_with_http_digest

  def index
    @posts = Post.includes(:user).order(created_at: :desc)
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    
    if @post.save
      redirect_to feeds_path, notice: 'โพสต์สำเร็จ'
    else
      redirect_to feeds_path, alert: 'เกิดข้อผิดพลาดในการโพสต์'
    end
  end

  private

  def post_params
    params.require(:post).permit(:content)
  end
end 