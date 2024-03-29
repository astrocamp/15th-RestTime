# frozen_string_literal: true

module Avo
  module Resources
    class LikeShop < Avo::BaseResource
      self.includes = []

      def fields
        field :id, as: :id
        field :user_id, as: :number
        field :shop_id, as: :number
        field :user, as: :belongs_to
        field :shop, as: :belongs_to
      end
    end
  end
end
