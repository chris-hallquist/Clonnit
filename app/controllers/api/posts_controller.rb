class Api::PostsController < ApplicationController
  before_filter :user_owns_link?, only: [:edit, :update]

  def create
    params[:post][:author_id] = current_user.id
    params[:post][:subclon_id] = params[:subclon_id]
    
    @post = Post.new(params[:post])
    
    if @post.save
      render :json => @post
    else
      flash[:errors] = @post.errors.full_messages
      render :new
    end
  end
  
  def new
    @post = Post.new
    @subclon = Subclon.find(params[:subclon_id])
  end
  
  def index
    @posts = Subclon.find(params[:subclon_id]).posts
    render "comments/index"
  end
  
  def show
    @post = Post.find(params[:id])
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
      @post = Post.find(params[:id])
    if @post.update_attributes(params[:post])
      render :json => @post
    else
      flash[:errors] = @post.errors.full_messages
      render :edit
    end
  end
  
  def user_owns_link?
    redirect_to @post unless Post.find(params[:id]).author == current_user
  end
end
