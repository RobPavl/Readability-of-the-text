class AddDetailsToTexts < ActiveRecord::Migration[6.0]
  def change
    add_column :texts, :fre, :decimal, precision: 6, scale: 3
    add_column :texts, :asl, :decimal, precision: 5, scale: 2
    add_column :texts, :asw, :decimal, precision: 5, scale: 2
    add_column :texts, :language, :string
  end
end
