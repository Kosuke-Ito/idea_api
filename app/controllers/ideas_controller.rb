class IdeasController < ApplicationController
  
  def index
    ideas = Idea.select(:id, :categories_id, :body, :created_at)

    if params[:category_name].present?
      category = Category.find_by(name: category_name)
      if category.present?
        ideas = ideas.includes(:categories).where(category: {name: params[:category_name]})
      else
        render status: 422
      end
    end
    ideas = ideas.map{ |i| [{id: i.id, categories_id: i.categories_id, body:i.body, created_at: i.created_at.to_i}] }.flatten

    render json: { data: ideas }, status: 201 
  end

  def create
    category_name = idea_params[:category_name]
    category = Category.find_by(name: category_name)
    if category.blank?
      category = Category.create(name: category_name)
    end
    idea = idea.new(body: idea_params[:body], categories_id: category.id)

    if idea.save
      render json: idea, status: 200
    else
      render json: idea.errors, status: 422
    end
  end

  private

  def idea_params
    params.permit(:category_name, :body)
  end
  
end
