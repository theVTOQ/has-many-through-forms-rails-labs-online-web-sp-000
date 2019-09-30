class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    binding.pry
  end
end
