class RecipesController < ApplicationController
  def show
    run Recipes::Show.new(params)
  end

  def index
    run Recipes::Index.new(params, current_user)
  end

  def create
  end

  def update
  end

  def delete
  end
end
