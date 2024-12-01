class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  include GenerateUuidv7
  include PgSearch::Model

  self.implicit_order_column = :created_at
end
