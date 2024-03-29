# frozen_string_literal: true

class ShopPolicy < ApplicationPolicy
  attr_reader :user, :shop

  def initialize(user, shop)
    @user = user
    @shop = shop
  end

  def index?
    user.vendor? || user.admin?
  end

  def new?
    user.admin?
  end

  def create?
    new?
  end

  def show?
    index?
  end

  def edit?
    index?
  end

  def update?
    index?
  end

  def destroy
    user.admin?
  end
end
