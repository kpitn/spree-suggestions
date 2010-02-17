class Admin::SuggestionsController < Admin::BaseController
  resource_controller
  before_filter :load_object, :only => [:selected, :available, :remove]

  belongs_to :product

  def selected
    @suggestions = @product.suggestions
  end

  def available
    if params[:q].blank?
      @available_suggestions = []
    else
      @available_suggestions = Product.find(:all,:include=>[:variants,:translations],:conditions => ['lower(name) LIKE ? OR lower(variants.sku) LIKE ?', "%#{params[:q].downcase}%", "%#{params[:q].downcase}%"])
    end
    @available_suggestions.delete_if { |suggestion| @product.suggestions.include?(suggestion) }
    respond_to do |format|
      format.html
      format.js {render :layout => false}
    end

  end

  def remove
    @product.suggestions.delete(@suggestion)
    @product.save
    @suggestions = @product.suggestions
    render :layout => false
  end

  def select
    @product = Product.find_by_param!(params[:product_id])
    suggestion = Product.find_by_permalink(params[:id])
    @product.suggestions << suggestion
    @product.save
    @suggestions = @product.suggestions
    render :layout => false
  end
end
