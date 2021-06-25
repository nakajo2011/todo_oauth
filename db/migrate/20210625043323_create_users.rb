class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :image
      t.string :openid

      t.timestamps
    end
  end
end
