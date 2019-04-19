class ReviewsController < ApplicationController

  #before_filter: authorize

  def create
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user_id = current_user.id
    @review.user = current_user

    if @review.save
      redirect_to Product.find(@review.product_id)
    else
      redirect_to Product.find(@review.product_id)
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy!
    redirect_to Product.find(@review.product_id)
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end
