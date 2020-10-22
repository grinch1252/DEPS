class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :title
      t.text :body
      t.boolean :disp_flg
      t.datetime :start
      t.datetime :end
      t.string :allDay
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :events, [:user_id]
  end
end
