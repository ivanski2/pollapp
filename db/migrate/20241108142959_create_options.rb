class CreateOptions < ActiveRecord::Migration[7.0]
  def change
    create_table :options do |t|
      t.references :poll, null: false, foreign_key: true
      t.string :content
      t.integer :vote_count

      t.timestamps
    end
  end
end
