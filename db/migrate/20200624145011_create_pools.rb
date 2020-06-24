class CreatePools < ActiveRecord::Migration[5.2]
  def change
    create_table :pools do |t|
      t.string :name
      t.bigint :contact
      t.string :from
      t.datetime :when

      t.timestamps
    end
  end
end
