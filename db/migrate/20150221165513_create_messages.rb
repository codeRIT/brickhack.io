class CreateMessages < ActiveRecord::Migration[4.2]
  def change
    create_table :messages do |t|
      t.string :name
      t.string :subject
      t.string :recipients
      t.text :body
      t.timestamp :queued_at
      t.timestamp :started_at
      t.timestamp :delivered_at

      t.timestamps
    end
  end
end
