# Structured rails application
This repo is an approach to architect rails app into a more enterprise way

### Architect
- The architecture is inspired by [Clean Architecture](https://8thlight.com/blog/uncle-bob/2012/08/13/the-clean-architecture.html)
- Using common pattern in rails like: `Service Object`, `Form Object`, `Policy`, `Presenter`
- Components:
    1. `View` using React.js
    2. `Controller` does nothing than delegate each action to `Service` (automatically). Controller will discover appropriate service
        For example:
        ```ruby
        class RecipesController < ApplicationController
          def show
          end
        end
        ```
        will discover `Recipes::Show` service and call it, then return data as `json`
    3. `Service` (Use Case) will do `business logic` and call `CQRS` or `ActiveRecord` for data access
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
        class RecipeValidator < Validator
          attr_accessor :title, :description, :prepare_time, :cook_time, :ready_time, :image
        
          validates :title, presence: true
          validates :image, presence: true
          validates :description, presence: true
          validates :prepare_time, numericality: true
          validates :cook_time, numericality: true
          validates :ready_time, numericality: true
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
[ ] Add sample for CQSR (Comman Query Separate Responsibility)
[ ] Add multiple steps create a model
