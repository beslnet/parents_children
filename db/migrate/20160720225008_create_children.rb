class CreateChildren < ActiveRecord::Migration
  def change
    create_table :children do |t|
      t.references :person, foreign_key: true
      t.references :mother, index: true
      t.references :father, index: true

      t.timestamps null: false
    end
    add_index :children, :person_id, unique: true
    add_foreign_key :children, :people, column: :mother_id
    add_foreign_key :children, :people, column: :father_id
  end
end
