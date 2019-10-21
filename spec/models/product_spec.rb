require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it "validated that a product will save with name, price, quantity and category set" do
      @category = Category.new(name: "testCat")
      @product = Product.new(name: "testName", price: 9001, quantity: 1, category: @category)
      expect(@product).to be_valid
      expect(@product.errors.full_messages).to_not be_present
    end

    it "validates that there should be a name" do
      @category = Category.new(name: "testCat")
      @product = Product.new(name: nil, price: 9001, quantity: 1, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to be_present
    end
    
    it "validates that there is a price" do
      @category = Category.new(name: "testCat")
      @product = Product.new(name: "testName", price: nil, quantity: 1, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to be_present
    end

    it "validates that there is a quantity" do
      @category = Category.new(name: "testCat")
      @product = Product.new(name: "testName", price: 9001, quantity: nil, category: @category)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to be_present
    end
      
    it "validates that there is a category" do
      @product = Product.new(name: "testName", price: 9001, quantity: nil, category: nil)
      expect(@product).to_not be_valid
      expect(@product.errors.full_messages).to be_present
    end

  end
end
