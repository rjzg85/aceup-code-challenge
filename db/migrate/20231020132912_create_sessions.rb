class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.string :coach_hash_id
      t.string :client_hash_id
      t.datetime :start
      t.integer :duration

      t.timestamps
    end
  end
end
