class Api::V1::CategoriesController < Api::V1::ApiController
  skip_before_action :authorize_user!, except: %i[create update destroy]
  before_action :set_category, except: [:create]

  def create
    if (@category = Category.create(category_params)).valid?
      render json: @category, serializer: CategorySerializer, status: :created
    else
      render json: { category_errors: @category.errors.messages }, status: :unprocessable_entity
    end
  end

  def update
    if @category.update(category_params)
      render json: @category, serializer: CategorySerializer, status: :ok
    else
      render json: { errors: @category.errors.messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @category.destroy
      render json: {}, status: :no_content
    else
      render json: { errors: @category.errors }, status: :unprocessable_entity
    end
  end

  private
  def category_params
    params.permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end
end
