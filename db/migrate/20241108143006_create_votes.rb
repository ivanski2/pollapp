class CreateVotes < ActiveRecord::Migration[7.0]
  def change
    create_table :votes do |t|
      t.references :poll, null: false, foreign_key: true
      t.references :option, null: false, foreign_key: true
      t.string :user_identifier

      t.timestamps
    end
  end
end
