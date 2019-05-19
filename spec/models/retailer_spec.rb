require 'rails_helper'

RSpec.describe Retailer, type: :model do
  it 'has a valid factory' do
    expect(build(:retailer)).to be_valid
  end

  let(:retailer) { create(:retailer) }

  describe 'model associations' do
    it { expect(retailer).to have_many(:offers) }
    it { expect(retailer).to have_many(:retailer_offers) }
  end
end
