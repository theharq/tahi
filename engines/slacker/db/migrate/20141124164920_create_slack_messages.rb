class CreateSlackMessages < ActiveRecord::Migration
  def change
    create_table :slacker_slack_messages do |t|
      t.string :username
      t.text :message
      t.belongs_to :slack_task
      t.timestamps
    end
  end
end
