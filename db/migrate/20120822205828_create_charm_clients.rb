class CreateCharmClients < ActiveRecord::Migration
  def change
    create_table :charm_clients do |t|
      t.string :title
      t.text :description
      t.string :status
      t.string :client_id
      t.string :client_secret
      t.integer :user_id

      t.timestamps
    end
  end
end
