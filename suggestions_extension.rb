# Uncomment this if you reference any of your controllers in activate
# require_dependency 'application'

class SuggestionsExtension < Spree::Extension
  version "1.0"
  description "Add Suggestion to Products"
  url "http://yourwebsite.com/"

  def activate
    # admin.tabs.add "Spree Accessories", "/admin/spree_accessories", :after => "Layouts", :visibility => [:all]

    Product.class_eval do
      has_and_belongs_to_many :suggestions, :class_name => "Product", :join_table => "suggestions" , :association_foreign_key => "suggestion_product_id"
    end


    # register Accessories product tab
    Admin::BaseController.class_eval do
      before_filter :add_suggestions_tab

      private
      def add_suggestions_tab
        @product_admin_tabs << {:name => t('suggestions'), :url => "selected_admin_product_suggestions_url"}
      end
    end

  end
end