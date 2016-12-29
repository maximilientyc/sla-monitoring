class Diagnostic < ActiveRecord::Base
  # includes :target to load target data : eager load
  belongs_to :target
end