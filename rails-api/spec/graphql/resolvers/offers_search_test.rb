require 'rails_helper'

module Resolvers
  class OffersSearchTest < ActiveSupport::TestCase
    def find(args)
      ::Resolvers::OffersSearch.call(nil, args, nil)
    end

    def create_offer(**attributes)
      Offer.create! attributes
    end

    test 'filter option' do
      offer1 = create_offer name: 'test1', description: 'this is a test'
      offer2 = create_offer name: 'test2', description: 'this is another test'
      offer3 = create_offer name: 'test3', description: 'testy testerson'
      offer4 = create_offer name: 'test4', description: 'the last test'

      result = find(
        filter: {
          'nameContains' => 'test1',
          'OR' => [{
            'nameContains' => 'test2',
            'OR' => [{
              'nameContains' => 'test3'
            }]
          }, {
            'descriptionContains' => 'test'
          }]
        }
      )
      binding.pry

      assert_equal result.map(&:description).sort, [offer1, offer2, offer3].map(&:description).sort
    end
  end
end
