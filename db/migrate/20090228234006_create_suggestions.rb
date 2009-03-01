class CreateSuggestions < ActiveRecord::Migration
  def self.up
    create_table :suggestions,{:id => false} do |t|
      t.references :product
      t.column :suggestion_product_id,     :integer, :null => false
    end
    add_index :suggestions, :product_id
  end

  def self.down
    drop_table :suggestions
  end
end
