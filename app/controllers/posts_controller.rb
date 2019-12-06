class PostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_post, only: %i[show update destroy]

    def index
      @posts = Post.all
      render :index
    end

    def show
      render :show
    end

    def create
      @post = Post.new(post_params.merge(user: current_user))
      count_index = IndexReadabilityService.calculate(@post.content)
      @post.index_readability = count_index
      if @post.save
        render :show, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def update
      if @post.update(post_params)
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

    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      params.require(:post).permit(:content, :index_readability)
    end
end
