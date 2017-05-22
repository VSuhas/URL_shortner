class AddColumnToUrl < ActiveRecord::Migration
  def change
    add_column :urls, :shortened_urls, :string
  end
end
