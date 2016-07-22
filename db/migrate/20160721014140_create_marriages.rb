class CreateMarriages < ActiveRecord::Migration
  def change
    create_table :marriages do |t|
      t.references :person, foreign_key: true
      t.references :spouse, index: true

      t.timestamps null: false
    end
    add_index :marriages, :person_id, unique: true
    add_foreign_key :marriages, :people, column: :spouse_id
  end
end
