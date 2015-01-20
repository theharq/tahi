# This migration comes from sample_card (originally 20150119204241)
class AddLexemeActiveColumn < ActiveRecord::Migration
  def change
    add_column :sample_card_lexemes, :active, :boolean
  end
end
