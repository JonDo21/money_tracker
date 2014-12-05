class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
      t.decimal :amount
      t.string :description
      t.references :user, index: true
      t.references :sharing_user, index: true

      t.timestamps
    end
  end
end
