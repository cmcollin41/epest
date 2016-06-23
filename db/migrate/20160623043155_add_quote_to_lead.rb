class AddQuoteToLead < ActiveRecord::Migration
  def change
    add_column :leads, :quote, :string
  end
end
