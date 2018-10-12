require 'rails_helper'
require 'spec_helper'

describe ReviewsController do
  describe "POST create" do
    let(:product) {Fabricate(:product)}

    context "with authenticated users" do
      let(:current_user) {Fabricate(:user)}
      before {set_current_user(current_user)}

      context "with valid inputs" do
        before do
          post :create, params: {review: Fabricate.attributes_for(:review, rating: 3), product_id: product.id}
        end

        it "redirects to the product show page" do
          expect(response).to redirect_to product
        end

        it "creates a review" do
          expect(Review.count).to eq(1)
        end

        it "creates a review associated with the video" do
          expect(Review.first.product).to eq(product)
        end

        it "creates a review associated with the signed in user" do
          expect(Review.first.user).to eq(current_user)
        end

        it "does not create more than one review for the same product" do
          post :create, params: {review: Fabricate.attributes_for(:review), product_id: product.id}
          expect(Review.count).to eq(1)
        end

        it "updates the product with the new review rating" do
          expect(Product.first.rating).to eq(3.00)
        end
      end

      context "with invalid inputs" do
        it "does not create a review" do
          post :create, params: {review: {rating: 4}, product_id: product.id}
          expect(Review.count).to eq(0)
        end

        it "renders the product/show template" do
          post :create, params: {review: {rating: 4}, product_id: product.id}
          expect(response).to render_template "products/show"
        end

        it "sets @product" do
          post :create, params: {review: {rating: 4}, product_id: product.id}
          expect(assigns(:product)).to eq(product)
        end

        it "sets @review" do
          post :create, params: {review: {rating: 4}, product_id: product.id}
          expect(assigns(:review)).to be_new_record
          expect(assigns(:review)).to be_instance_of(Review)
        end

        it "sets @reviews" do
          review = Fabricate(:review, product: product)
          post :create, params: {review: {rating: 4}, product_id: product.id}
          expect(assigns(:reviews)).to match_array([review])
        end

        it "displays error message" do
          post :create, params: {review: {rating: 4}, product_id: product.id}
          expect(flash[:danger]).to eq("Invalid review. Please check the errors below.")
        end
      end
    end

    it_behaves_like "require sign in" do
      let(:action) {post :create, params: {id: 3, product_id: 4}}
    end
  end

  describe "DELETE destroy" do
    let(:product) {Fabricate(:product, rating: 3.00)}
    let(:review){Fabricate(:review, user_id: alice.id, product_id: product.id)}
    let(:alice) {Fabricate(:user)}
    let(:bob) {Fabricate(:user)}
    before {set_current_user(alice)}

    it "removes the review rating from the product" do
      delete :destroy, params: {id: review.id, product_id: product.id}
      expect(Product.first.rating).to be_nil
    end

    it "deletes the review" do
      delete :destroy, params: {id: review.id, product_id: product.id}
      expect(Review.count).to eq(0)
    end

    it "does not delete another user's review" do
      bob_review = Fabricate(:review, user_id: bob.id, product_id: product.id)
      delete :destroy, params: {id: bob_review.id, product_id: product.id}
      expect(Review.count).to eq(1)
    end

    it "redirects to the user show page" do
      delete :destroy, params: {id: review.id, product_id: product.id}
      expect(response).to redirect_to alice
    end
  end

  it_behaves_like "require sign in" do
    let(:action) {delete :destroy, params: {id: 3, product_id: 4}}
  end
end
