require 'rails_helper'

RSpec.describe RetailerOffer, type: :model do
  it 'has a valid factory' do
    expect(build(:offer)).to be_valid
  end

  let(:retailer_offer) { create(:retailer_offer) }

  describe 'model associations' do
    it { expect(retailer_offer).to belong_to(:retailer) }
    it { expect(retailer_offer).to belong_to(:offer) }
  end
end
