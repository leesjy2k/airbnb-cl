class CreateListings < ActiveRecord::Migration
  def change
    create_table :listings do |t|
      t.integer :user_id
      t.string :title
      t.text :description
	  t.string   :home_type
	  t.string   :location
	  t.integer  :guest
	  t.integer  :bedroom
	  t.integer  :price
	  t.json     :images
	  t.boolean  :breakfast
	  t.timestamps null: false
    end
  end
end
