class CreatePollWinners < ActiveRecord::Migration[7.0]
  def change
    create_table :poll_winners do |t|
      t.references :poll, foreign_key: true
      t.references :candidate, foreign_key: true

      t.timestamps
    end
  end
end
