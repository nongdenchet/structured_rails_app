# Structured rails application [![Build Status](https://travis-ci.org/nongdenchet/structured_rails_app.svg?branch=master)](https://travis-ci.org/nongdenchet/structured_rails_app) [![Coverage Status](https://coveralls.io/repos/github/nongdenchet/structured_rails_app/badge.svg?branch=master)](https://coveralls.io/github/nongdenchet/structured_rails_app?branch=master)
This repo is an approach to architect rails app into a more enterprise way

### Setup
- Run `bundle install` to install gem
- Run `npm install` to install node.js libraries
- Run `npm run postinstall` to install libraries for client side
- Run `npm run rails` to start server and development mode
- Run `rails db:create db:migrate` to init database
- Run `rails db:migrate RAILS_ENV=test` then `spring rspec spec` to run the test suites

### Architect
- The architecture is inspired by [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)
- Using common pattern in rails like: `Service Object`, `Form Object`, `Policy`, `Query Object`.
- Components:
    1. `Controller` does nothing than delegate each action to `Service` (automatically). Controller will discover appropriate service
        
        For example:
        ```ruby
        class RecipesController < ApplicationController
          before_action :execute  
        
          def create
          end
        end
        ```
        `before_action :execute` will discover `Recipes::Show` service and call it, then return data as `json`
    2. `Service` (Use Case) will do `business logic` and call `Query` or `ActiveRecord` for data access. We can get rid off many `before_action` from `Controller` and delegate them to `Service` for example using `require_authen!`
    
        For example:
        ```ruby
        module Recipes
          module V1
            class Create < Service
              require_authen!
        
              def process
                validate!
                recipe = user.recipes.create!(recipe_params)
                Recipes::Serializer.new(recipe)
              end
        
              private
              def recipe_params
                params.require(:recipe).permit(
                  :title,
                  :description,
                  :image,
                  :prepare_time,
                  :cook_time,
                  :ready_time
                )
              end
            end
          end
        end
        ```
    3. `Query` to execute complicated SQL query.
    
        For example:
        ```ruby
        module Recipes
          class DetailQuery
            def execute
              Recipe
                .select('recipes.*, review_infos.average AS average_rating,
                         review_infos.count AS review_count,
                         complete_infos.count AS complete_count')
                .joins("LEFT OUTER JOIN (#{review_infos.to_sql}) AS review_infos
                        ON review_infos.recipe_id = recipes.id")
                .joins("LEFT OUTER JOIN (#{complete_infos.to_sql}) AS complete_infos
                        ON complete_infos.recipe_id = recipes.id")
            end
        
            private
            def review_infos
              Review
                .select('recipe_id, COALESCE(AVG(reviews.rating), 0) AS average,
                         COUNT(reviews.id) AS count')
                .group('recipe_id')
            end
        
            def complete_infos
              Complete
                .select('recipe_id, COUNT(completes.id) AS count')
                .group('recipe_id')
            end
          end
        end
        ```
    4. `Model` include only fields and assocications.
        
        For example:
        ```ruby
        class Recipe < ApplicationRecord
          mount_uploader :image, ImageUploader
        
          belongs_to :user
          has_many :ingredients, dependent: :destroy
          has_many :directions, dependent: :destroy
        end
        ```
    5. `Validator` (Form Object) will do validation logic
        
        For example:
        ```ruby
        module Recipes
          class CreateValidator < Validator
            attr_accessor :title, :description, :prepare_time, :cook_time, :ready_time, :image
        
            validates :title, presence: true
            validates :image, presence: true
            validates :description, presence: true
            validates :prepare_time, numericality: true
            validates :cook_time, numericality: true
            validates :ready_time, numericality: true
        
            def self.require_params(params)
              params.require(:recipe)
                .permit(:title, :description, :prepare_time, :cook_time, :ready_time, :image)
            end
          end
        end
        ```
    6. `Policy` for authorization
        
        For example:
        ```ruby
        class ReviewsPolicy
          def self.create?(user, record)
            user.id != record.user_id
          end
        
          def self.destroy?(user, record)
            user.id == record.user_id
          end
        end
        ```
    7. `Serializer` (Presenter) for prepare data to return to the view
        
        For example:
        ```ruby
        module Recipes
          class Serializer < ActiveModel::Serializer
            attributes :id, :title, :description, :image, :prepare_time, :cook_time, :ready_time
        
            belongs_to :user, serializer: Users::ShortSerializer
            has_many :ingredients, serializer: Ingredients::Serializer
            has_many :directions, serializer: Directions::Serializer
          end
        end
        ```
