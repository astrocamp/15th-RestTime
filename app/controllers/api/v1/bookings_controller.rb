# frozen_string_literal: true

module Api
  module V1
    class BookingsController < ApplicationController
      before_action :find_shop, only: [:available_slots]

      def available_slots
        product = @shop.products.find_by(id: params[:product])

        booking_service = BookingService.new(@shop, product)
        available_slots = booking_service.display_available_slots(
          DateTime.parse(params[:booking_date], '%Y/%m/%d %H:%M')
        )
        render json: { available_slots: }
      end

      private

      def find_shop
        @shop = Shop.find(params[:id])
      end
    end
  end
end
