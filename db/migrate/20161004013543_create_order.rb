class CreateOrder < ActiveRecord::Migration
  def change

  	create_table :orders do |t|
  	  t.text :order_input
  	  t.text :name
  	  t.text :phone
  	  t.text :email
  	  t.text :address

  	  t.timestamps
  	end
  	
  end
end
