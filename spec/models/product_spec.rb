require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new({:name => 'appliances'})
      
    end

    it "should have all the necesary parameters" do 
      @product = Product.new({:category => @category, :name => 'desk', :price_cents => 30000, :quantity => 34})
      expect(@product.save).to eq(true)
    end

    it "should raise error if product doesnt have a price" do 
      @product = Product.new({:category => @category, :name => 'desk', :price_cents => nil, :quantity => 34})
      expect(@product.save).to eq(false)
      expect(@product.errors.full_messages).to eq(["Price cents is not a number", "Price is not a number", "Price can't be blank"])
    end

    it "should raise error if product doesnt have a quantity" do
      @product = Product.new({:category => @category, :name => 'desk', :price_cents => 30000, :quantity => nil})
      expect(@product.save).to eq(false)
      expect(@product.errors.full_messages).to eq(["Quantity can't be blank"])
    end

    it "should raise error if product doesnt have a category" do
      @product = Product.new({:category => nil, :name => 'desk', :price_cents => 30000, :quantity => 34})
      expect(@product.save).to eq(false)
      expect(@product.errors.full_messages).to eq(["Category can't be blank"])
    end

    it "should raise error if product doesnt have a name" do
      @product = Product.new({:category => @category, :name => nil, :price_cents => 30000, :quantity => 34})
      expect(@product.save).to eq(false)
      expect(@product.errors.full_messages).to eq(["Name can't be blank"])
    end
  end
end
