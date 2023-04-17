class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  COLUMNS_TO_EXCLUDE = %w( id updated_at created_at)

  def self.column_names
    super - COLUMNS_TO_EXCLUDE
  end
end
