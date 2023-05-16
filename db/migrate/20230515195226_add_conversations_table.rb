class AddConversationsTable < ActiveRecord::Migration[7.0]
  def change
    create_table :conversations do |t|
      t.references :appointment, null: false
      t.timestamps
    end
  end
end
