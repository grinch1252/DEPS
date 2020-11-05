class CreateSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :subjects do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :total_time, default: 0
      t.string :picture
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
