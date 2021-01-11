require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    before do
      @category = Category.new({:name => 'appliances'})
      
    end

    it "should have all the necesary parameters" do 
      @product = Product.new({:category => @category, :name => 'desk', :price => 30000, :quantity => 34})
      expect(@product.save).to eq(true)
    end

    it "should raise error if product doesnt have a price" do 
    end

    it "should raise error if product doesnt have a quantity" do 
    end

    it "should raise error if product doesnt have a category" do 
    end

    it "should raise error if product doesnt have a name" do 
    end
  end
end
