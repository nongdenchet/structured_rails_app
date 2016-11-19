class RecipesController < ApplicationController
  def show
    run Recipes::Show.new(params)
  end

  def index
  end

  def create
  end

  def update
  end

  def delete
  end
end
