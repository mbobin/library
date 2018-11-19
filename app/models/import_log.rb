class ImportLog < ApplicationRecord
  scope :with_error, -> { where("data->>'error' IS NOT NULL") }
  scope :halted, -> { where("data->>'halted' IS NOT NULL") }

  def fail?
    data["error"]
  end

  def halted?
    data["halted"]
  end

  def has_file?
    data["file_path"].present? && File.exist?(data["file_path"])
  end

  def remove_file!
    File.unlink(data["file_path"]) if has_file?
  end
end
