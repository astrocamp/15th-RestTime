# frozen_string_literal: true

class ServiceTime < ApplicationRecord
  belongs_to :shop
  before_validation :validate_open_and_close_times, on: :update

  default_scope { order(id: :desc) }

  # 預設寫入週一至週日共七筆設定資料
  def self.default_data(shop)
    days = %w[monday tuesday wednesday thursday friday saturday sunday]
    days.each do |day|
      shop.service_times << ServiceTime.build(day_of_week: day, shop:)
    end
  end

  private

  def validate_open_and_close_times
    return if off_day

    if open_time.present? && close_time.blank?
      errors.add(:base, :close_time_blank)
      return
    end

    return unless close_time.present? && open_time.blank?

    errors.add(:base, :open_time_blank)
  end
end
