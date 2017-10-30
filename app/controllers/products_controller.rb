class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
  end

  def add_to_cart
    @product = Product.find(params[:id])
    # 与教材相比有改动-start1
    @cart = current_cart
    @cart_item = @cart.cart_items.find_by(product_id: params[:id])
    # 与教材相比有改动-end1
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "你已成功将 #{@product.title} 加入购物车"
    else
      # 与教材相比有改动-start2
      @cart_item.quantity += 1
      @cart_item.save
      flash[:warning] = '购物车内此物品数量加1'
      # 与教材相比有改动-end2
    end
    redirect_to :back
  end
end
