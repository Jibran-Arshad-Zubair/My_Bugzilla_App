# frozen_string_literal: true

class CreateManagers < ActiveRecord::Migration[6.1]
  def change
    create_table :managers do |t|
      t.string :name
      t.timestamps
    end
  end
end
