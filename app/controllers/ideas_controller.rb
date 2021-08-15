class IdeasController < ApplicationController
  def index
    category = Category.find_by(name: params[:category_name])

    render status: 422 and return if params[:category_name] && !category

    ideas = if params[:category_name]
              category.ideas
            else
              Idea.all
            end

    ideas = ideas.map { |i| { id: i.id, category: i.category.name, body: i.body, created_at: i.created_at.to_i } }
    render json: { data: ideas }, status: 201
  end

  def create
    category = Category.find_or_create_by(name: idea_params[:category_name])
    idea = Idea.new(body: idea_params[:body], category: category)

    if idea.save
      render json: idea, status: 201
    else
      render json: idea.errors, status: 422
    end
  end

  private

  def idea_params
    params.permit(:category_name, :body)
  end
end
