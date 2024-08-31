class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]

  # GET /posts or /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1 or /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  def next_step
    @post = Post.new(post_params)
    @next_step = params[:step].to_i
    @current_step = @next_step - 1

    if @post.step_valid?(@current_step)
      render partial: "posts/form_step_#{@next_step}", locals: { post: @post }
    else
      render partial: "posts/form_step_#{@current_step}", locals: { post: @post }
    end
  end

  def previous_step
    @post = Post.new(post_params)
    @previous_step = params[:step].to_i

    render partial: "posts/form_step_#{@previous_step}", locals: { post: @post }
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts or /posts.json
  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to @post, notice: "Post was successfully created."
    else
      render partial: "posts/form_step_3", locals: { post: @post }
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.fetch(:post, {}).permit(:title, :description, :published_at)
    end
end
