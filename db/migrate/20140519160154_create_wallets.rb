class CreateWallets < ActiveRecord::Migration
  def change
    create_table :wallets do |t|
      t.belongs_to :user
    end
  end
end
