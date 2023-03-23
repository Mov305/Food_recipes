# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Create a main sample user.
main_user = User.first 
# create a recipe for the main user
Recipe.create!(name: "Example", user: main_user, preparation_time: 10, cooking_time: 10, description: "This is an example recipe", public: true)
# create a food for the main user
Food.create!(name: "Example", user: main_user, price: 10, measurement_unit: "kg")

# Generate a bunch of additional users.
RecipeFood.create!(recipe_id: 1, food_id: 1, quantity: 1)
