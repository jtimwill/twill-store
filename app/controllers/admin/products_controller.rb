class Admin::ProductsController < AdminsController
  def new
    @product = Product.new
  end

  def create
    @product = Product.new(admin_products_params)
    if @product.save
      flash[:success] = "You've added a new product called '#{@product.title}'"
      redirect_to new_admin_product_path
    else
      flash.now[:danger] = "Product creation failed."
      render :new
    end
  end

  def destroy
    @product = Product.find(params[:id])
    @product.destroy if current_user.admin?
    redirect_to products_path
  end

  private

  def admin_products_params
    params.require(:product).permit(:title, :description, :category, :large_image_path, :small_image_path)
  end
end
