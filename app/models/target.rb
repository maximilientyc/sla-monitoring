class Target < ActiveRecord::Base
  # has_many :target_life_check_command_diagnostics use className and table name explicitly
  validates :life_url, :timeout, presence: true
  has_many :diagnostics
end
