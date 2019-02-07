class PipelineConvertJob < ApplicationJob
  def perform(document)
    Pipeline::Convert.call("convertable_document" => document)
  end
end
