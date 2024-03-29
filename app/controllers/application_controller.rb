# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include Pundit::Authorization
  around_action :switch_locale
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ActiveRecord::RecordNotSaved, with: :not_saved
  rescue_from Pundit::NotAuthorizedError, with: :not_authorized

  layout :set_layout # 設置判斷登入的使用者layout頁面
  helper_method :show_vendor_link?
  helper_method :current_user_shop, :current_booking, :booking_shop, :booking_product

  def show_vendor_link
    authorize :application, :show_vendor_stuff?
  end

  protect_from_forgery with: :exception

  def not_found
    render file: Rails.public_path.join('404.html'),
           status: 404,
           layout: false
  end

  def not_saved
    render file: Rails.public_path.join('422.html'),
           status: 422,
           layout: false
  end

  def default_url_options
    { lang: I18n.locale }
  end

  def switch_locale(&)
    lang = params[:lang] || I18n.default_locale
    I18n.with_locale(lang, &)
  end

  def current_user_shop
    current_user.shop
  end

  def set_layout
    if user_signed_in? && current_user.vendor?
      'vendor'
    else
      'application'
    end
  end

  def not_authorized
    redirect_to root_path, alert: '權限不足'
  end

  def current_booking
    return unless user_signed_in?

    @current_booking ||= current_user.booking || current_user.create_booking
  end

  def booking_shop
    current_booking.product.shop
  end

  def booking_product
    current_booking.product
  end
end
