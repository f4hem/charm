class CreateFlirtEvents < ActiveRecord::Migration
  def change
    create_table :flirt_events do |t|
      t.string :scope
      t.integer :token_id
      t.text :details

      t.timestamps
    end
  end
end
