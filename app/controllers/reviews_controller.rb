class ReviewsController < ApplicationController

  #before_filter: authorize

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
    redirect_to "/products/#{@review.product_id}"
  end

  private

  def review_params
    params.require(:review).permit(
      :rating,
      :description
    )
  end

  def authorize
    unless current_user
      flash[:error] = "You must be logged in to access this section."
      redirect_to [:login]
    end
  end

end
