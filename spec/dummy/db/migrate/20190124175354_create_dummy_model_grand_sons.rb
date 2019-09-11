class CreateDummyModelGrandSons< ActiveRecord::Migration[5.2]
  def change
    create_table :dummy_model_grand_sons do |t|
      t.string :name
      t.integer :something
      t.references :dummy_model_son, foreign_key: true
    end
  end
end
