require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") }
  #subject(:name) { Chef.new('Nick')}
  subject(:brownie) {Dessert.new('brownie',10,chef) }

  describe "#initialize" do
    it "sets a type" do
      expect(brownie.type).to eql('brownie')
    end

    it "sets a quantity" do 
      expect(brownie.quantity).to eql(10)
    end

    it "starts ingredients as an empty array" do 
      expect(brownie.ingredients).to match_array([])
    end


    it "raises an argument error when given a non-integer quantity" do 
      expect(brownie.quantity).to be_a (Integer)
    end
  end

  describe "#add_ingredient" do
    before (:each) do
      brownie.add_ingredient('sugar')
      brownie.add_ingredient('eggs')
      brownie.add_ingredient('chocolate')
    end
    it "adds an ingredient to the ingredients array" do
      expect(brownie.ingredients).to include('sugar')
    end
  end

  describe "#mix!" do
    before (:each) do
      brownie.add_ingredient('sugar')
      brownie.add_ingredient('eggs')
      brownie.add_ingredient('chocolate')
    end
    it "shuffles the ingredient array" do
      expect(brownie.mix!).not_to eql(['sugar','eggs','chocolate'])
    end
  end

  describe "#eat" do
    it "subtracts an amount from the quantity" do
      expect(brownie.eat(5)).to eq(5)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect{brownie.eat(11)}.to raise_error("not enough left!")
    end
  
  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      allow(chef).to receive(:titleize).and_return("Nick")

      expect(brownie.serve).to include("Nick")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to receive(:bake).with(brownie)
      brownie.make_more
    end
  end
end
