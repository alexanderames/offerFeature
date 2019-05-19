require 'search_object/plugin/graphql'

class Resolvers::OffersSearch
  # include SearchObject for GraphQL
  include SearchObject.module(:graphql)

  # scope is starting point for search
  scope { Offer.all }

  type types[Types::OfferType]

  # inline input type definition for the advance filter
  class OfferFilter < ::Types::BaseInputObject
    argument :OR, [self], required: false
    argument :name_contains, String, required: false
    argument :description_contains, String, required: false
  end

  # when "filter" is passed "apply_filter" would be called to narrow the scope
  option :filter, type: OfferFilter, with: :apply_filter

  # apply_filter recursively loops through "OR" branches
  def apply_filter(scope, value)
    branches = normalize_filters(value).reduce { |a, b| a.or(b) }
    scope.merge branches
  end

  def normalize_filters(value, branches = [])
    scope = Offer.all
    scope = scope.like(:name, value[:name_contains]) if value[:name_contains]
    scope = scope.like(:description, value[:description_contains]) if value[:description_contains]

    branches << scope

    value['OR'].reduce(branches) { |s, v| normalize_filters(v, s) } if value['OR'].present?

    branches
  end
end
