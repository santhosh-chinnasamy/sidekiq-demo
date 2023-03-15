class PostsController < ApplicationController
  before_action :set_post, only: %i[show update destroy]

  # GET /posts
  def index
    @posts = Post.all

    render json: { total: Post.count, data: @posts }
  end

  # GET /posts/1
  def show
    render json: @post
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end

  def bulk_create_without_worker
    count = params[:count] || 10
    posts = count.to_i.times.map do
      { name: Faker::Name.name, title: Faker::Lorem.sentence, content: Faker::Lorem.paragraph }
    end
    Post.create!(posts)
    render json: { message: "#{count.to_i} posts created" }
  end

  def bulk_create
    type = params[:type]
    count = params[:count] || 10

    BulkPostJob.perform_async(type, count&.to_i)
    render json: { message: 'Bulk creation started' }
  end

  def bulk_create_v2
    count = params[:count] || 10

    BulkPostJobV2.create(count&.to_i)
    render json: { message: 'Bulk creation started' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:name, :title, :content)
  end
end
