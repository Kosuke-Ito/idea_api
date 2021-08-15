class CategoriesController < ApplicationController

  def create
    category = Category.new(category_params)
    category.save
  end

  private

    def category_params
      params.permit(:name)
    end
  
end
