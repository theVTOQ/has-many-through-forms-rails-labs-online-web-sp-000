class PostsController < ApplicationController
  def show
    @post = Post.find(params[:id])
  end

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    post = Post.create(post_params)
    redirect_to post
  end

  def update
    post = Post.find(params[:id])

    if !params[:comment].empty?
      content = params[:comment][:content]
      user_id = params[:comment][:user_id]
      username = params[:comment][:user_attributes][:username]

      comment = Comment.create(content: content)
      user = nil
      if !user_id.blank?
        user = User.find(user_id)
      elsif !username.blank?
        user = User.find_or_create_by(username: username)
      end

      comment.user = user #if user != nil
      comment.post = post
      comment.save
      post.save
      #binding.pry
    else

    end
    #as yet, we are not editing the data of the post, only creating a comment
    #for the post
    #post.update!(post_params)
    redirect_to post
  end

  private

  def post_params
    params.require(:post).permit(
      :title, :content, :user_id, category_ids:[],
      categories_attributes: [:name],
      comment_attributes: [:content, :user_id, user_attributes: [:username]]
    )
  end
end
