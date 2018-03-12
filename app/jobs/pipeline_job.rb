class PipelineJob < ApplicationJob
  def perform(path)
    Pipeline::Create.call("file_path" => path)
  end
end
