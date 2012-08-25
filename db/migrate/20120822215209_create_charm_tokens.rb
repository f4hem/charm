class CreateCharmTokens < ActiveRecord::Migration
  def change
    create_table :charm_tokens do |t|
      t.string :token
      t.integer :user_id
      t.string :scope
      t.datetime :expire_at
      t.datetime :valid_thru
      t.integer :client_id

      t.timestamps
    end
  end
end
