class RecipesController < ApplicationController

    def index
        if session[:user_id]
            recipes = Recipe.all 
            render json: recipes, status: :created
        else
            render json: { "errors": ["Not authorized"] }, status: :unauthorized
        end
    end

    def create
        if session[:user_id]
            user = User.find(session[:user_id])
            recipe = user.recipes.create!(recipe_params)
            render json: recipe, status: :created
        else
            render json: { "errors": ["Not authorized"] }, status: :unauthorized
        end
    end

    private

    def recipe_params
        params.permit(:title, :instructions, :minutes_to_complete)
    end
end
