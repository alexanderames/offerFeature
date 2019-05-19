require 'rails_helper'

RSpec.describe Offer, type: :model do
  it 'has a valid factory' do
    expect(build(:offer)).to be_valid
  end

  let(:attributes) do
    {
      name: 'Sams Club'
    }
  end

  let(:offer) { create(:offer, **attributes) }

  describe 'model validations' do
    it { expect(offer).to allow_value(attributes[:name]).for(:name) }
  end

  describe 'model associations' do
    it { expect(offer).to have_many(:retailers) }
    it { expect(offer).to have_many(:retailer_offers) }
  end
end
