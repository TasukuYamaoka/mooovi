class TableDelate < ActiveRecord::Migration
  def change
    drop_table:products
    drop_table:reviews
  end
end
