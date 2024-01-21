class Domain < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  belongs_to :internet_protocol
end
