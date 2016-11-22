# Structured rails application [![Build Status](https://travis-ci.org/nongdenchet/structured_rails_app.svg?branch=master)](https://travis-ci.org/nongdenchet/structured_rails_app) [![Coverage Status](https://coveralls.io/repos/github/nongdenchet/structured_rails_app/badge.svg?branch=master)](https://coveralls.io/github/nongdenchet/structured_rails_app?branch=master)
This repo is an approach to architect rails app into a more enterprise way

### Setup
- Run `bundle install` to install gem
- Run `npm install` to install node.js libraries
- Run `npm run rails` to start server and development mode
- Run `rails db:create db:migrate` to init database
- Run `spring rspec spec` to run the test suites

### Architect
- The architecture is inspired by [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)
- Using common pattern in rails like: `Service Object`, `Form Object`, `Policy`, `Presenter`.
- Components:
    1. `View` using React.js
    2. `Controller` does nothing than delegate each action to `Service` (automatically). Controller will discover appropriate service
        
        For example:
        ```ruby
        class RecipesController < ApplicationController
          before_action :execute  
        
          def show
          end
        end
        ```
        `before_action :execute` will discover `Recipes::Show` service and call it, then return data as `json`
    3. `Service` (Use Case) will do `business logic` and call `CQSR` or `ActiveRecord` for data access. We can get rid off many `before_action` from `Controller` and delegate them to `Service` for example using `require_authen!`
    
        For example:
        ```ruby
        module Recipes
          class Index < Service
            require_authen!
        
            def process
              recipes = user.recipes
              recipes.map { |recipe| serialize(recipe) }
            end
        
            private
            def serialize(recipe)
              Recipes::ShortSerializer.new(recipe)
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
        class RecipePolicy
          def self.destroy_record?(user, record)
            check_owner(user, record)
          end
        
          def self.update_record?(user, record)
            check_owner(user, record)
          end
        
          private
          def self.check_owner(user, record)
            user.id == record.user_id
          end
        end
        ```
    7. `Serializer` (Presenter) for prepare data to return to the view
        
        For example:
        ```ruby
        module Recipes
          class DetailSerializer < ActiveModel::Serializer
            attributes :id, :title, :description, :image, :prepare_time, :cook_time, :ready_time
        
            belongs_to :user, serializer: Users::ShortSerializer
          end
        end
        ```

### Todo
- [ ] Add sample for CQRS (Command Query Responsibility Separate)
- [x] Add sample multiple steps to create a model
- [x] Add more complex use cases
- [ ] Add support for multiple view type (html and js)
