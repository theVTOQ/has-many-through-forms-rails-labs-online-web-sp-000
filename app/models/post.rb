class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :comments

  def unique_user_comments
    user_comments = {}
    self.comments.each do |comment|
      if user_comments.key?(comment.user)
        user_comments[comment.user] << comment.content
      else
        user_comments[comment.user] = [comment.content]
      end
    end
    user_comments
  end

  def category_ids=(ids)
    ids.each do |id|
      if id != ""
        category = Category.find(id)
        self.categories << category
      end
    end
  end

  def categories_attributes=(categories_attributes)
    categories_attributes.values.each do |category_attr|
      category = Category.find_or_create_by(category_attr)
      self.post_categories.build(category: category)
    end
  end
end
