class CreateGameSessions < ActiveRecord::Migration
  def change
    create_table :game_sessions do |t|
      t.string :date
      t.string :amount_won
      t.text :notes
    end
  end
end
