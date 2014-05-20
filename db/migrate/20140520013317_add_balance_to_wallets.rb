class AddBalanceToWallets < ActiveRecord::Migration
  def change
    add_column("wallets", "balance", :float)
  end
end
