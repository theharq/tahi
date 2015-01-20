# This migration comes from sample_card (originally 20150116164322)
class CreateSampleCardLexemes < ActiveRecord::Migration
  def change
    create_table :sample_card_lexemes do |t|
      t.integer :journal_id
      t.text :word_form
      t.timestamps null: false
    end
  end
end
