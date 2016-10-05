class CreateProduct < ActiveRecord::Migration
  def change

  	create_table :products do |t|
		t.string :title
		t.text :author
		t.text :description
		t.text :subject
		t.decimal :size
		t.decimal :price
		t.string :path_to_image
		t.text :cover
		t.boolean :is_dust_jacket

  		t.timestamps
  	end

  end
end
