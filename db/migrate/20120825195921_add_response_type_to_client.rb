class AddResponseTypeToClient < ActiveRecord::Migration
  def change
    add_column :charm_clients, :response_type, :string
    add_column :charm_clients, :redirect_uri, :string
    add_column :charm_clients, :scope, :string
  end
end
