class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.references :author
      t.string :title

      t.timestamps
    end
  end
end
