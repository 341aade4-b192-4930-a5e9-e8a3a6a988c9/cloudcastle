class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.integer :rating1
      t.integer :rating2

      t.timestamps
    end
  end
end
