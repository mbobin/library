namespace :import do
  desc "import files from location"
  task :files, [:path] => :environment do |_task, args|
    files_path = args[:path]
    unless files_path.present?
      puts "no files in this path"
      exit(1)
    end

    Dir.glob(Pathname(files_path).expand_path).each do |path|
      puts "importing #{path}"
      PipelineJob.perform_later(path)
    end
  end

  task clean: :environment do
    ImportLog.halted.where("data->>'halted_from' = 'Pipeline::Checksum' AND data->>'halted_reason' = 'Document already exists'").find_each { |l| l.remove_file! if l.has_file? }
  end
end
