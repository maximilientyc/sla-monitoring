class Target < ActiveRecord::Base
  validates :life_url, :timeout, presence: true
  has_many :diagnostics
end
