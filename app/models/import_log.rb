class ImportLog < ApplicationRecord
  scope :with_error, -> { where("data->>'error' IS NOT NULL") }
  scope :halted, -> { where("data->>'halted' IS NOT NULL") }

  def fail?
    data["error"] || data["halted"]
  end
end
