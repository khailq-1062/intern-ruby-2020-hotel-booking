class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password
      t.string :activation_digest
      t.boolean :activated
      t.datetime :activated_at
      t.string :password_digest
      t.string :remember_digest
      t.string :reset_digest
      t.datetime :reset_sent_at
      t.integer :role

      t.timestamps
    end
  end
end
