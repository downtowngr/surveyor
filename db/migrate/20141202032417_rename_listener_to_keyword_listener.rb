class RenameListenerToKeywordListener < ActiveRecord::Migration
  def change
    rename_table :listeners, :keyword_listeners
  end
end
