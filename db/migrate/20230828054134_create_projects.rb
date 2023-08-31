# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[6.1]
  def change
    create_table :projects do |t|
      t.string :name
      # t.references :manager, null: false, foreign_key: true

      t.timestamps
    end
  end
end
