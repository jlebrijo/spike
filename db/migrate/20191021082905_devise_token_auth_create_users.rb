class DeviseTokenAuthCreateUsers < ActiveRecord::Migration[6.0]
  def change
    
    change_table(:users) do |t|
      ## Required
      t.string :provider, :null => false, :default => "email"
      t.string :uid, :null => false, :default => ""

      ## Recoverable
      t.boolean  :allow_password_change, default: true

      ## Tokens
      t.json :tokens
    end

    add_index :users, [:uid, :provider],     unique: true
  end
end
