require 'rails_helper'

RSpec.describe Recipe, type: :model do
  user = User.create(name: 'Emmanuel', email: 'abc@abc.com')
  subject do
    Recipe.new(
    )
  end
 
