class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :last_4_digits
      t.string :stripe_id
      t.string :authentication_token
      
      t.timestamps
    end
  end
end
