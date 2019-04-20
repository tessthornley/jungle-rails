class ReviewsController < ApplicationController

  def create
    @review = Review.new(review_params)
    @review.product_id = params[:product_id]
    @review.user_id = current_user.id
    

    if @review.save
      redirect_to "/products/#{@review.product_id}", notice: 'Review Created!'
    else
      redirect_to "/products/#{@review.product_id}"
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy!
    redirect_to Product.find(@review.product_id)
  end

  #before_filter: authorize

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

end
