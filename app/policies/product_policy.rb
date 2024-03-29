# frozen_string_literal: true

class ProductPolicy < ApplicationPolicy
  attr_reader :user, :product

  def initialize(user, product)
    @user = user
    @product = product
  end

  def index?
    true
  end

  def show?
    true
  end

  def my?
    user.vendor? || user.admin?
  end

  def new?
    my?
    # 同上
  end

  def create?
    my?
    # 同上
  end

  def edit?
    user&.own?(product) || user&.admin?
    # 只能編輯自己的商品 or 管理員能編輯
  end

  def update?
    edit?
    # 同上
  end

  def destroy?
    edit?
    # 同上
  end

  def search?
    true
  end
end
