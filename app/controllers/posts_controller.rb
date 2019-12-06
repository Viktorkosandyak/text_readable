class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show update destroy]
  before_action :authorize_policy, except: [:create]

  def index
    @posts = Post.all
    render :index
  end

  def show
    render :show
  end

  def create
    @post = Post.new(post_params.merge(user: current_user))
    @post.index_readability = IndexReadabilityService.calculate(@post.content)
    if @post.save
      render :show, status: :created
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
        @post.index_readability = IndexReadabilityService.calculate(@post.content)
      render :show, status: 200
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @post.destroy
      render :show, status: 200
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  private

  def authorize_policy
    action_name == 'index' ? authorize(Post) : authorize(@post)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
