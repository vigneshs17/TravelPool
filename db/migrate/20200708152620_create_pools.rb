class CreatePools < ActiveRecord::Migration[6.0]
  def change
    create_table :pools do |t|
      t.string :name
      t.bigint :contact
      t.string :where
      t.datetime :when

      t.timestamps
    end
  end
end
