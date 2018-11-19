namespace :import do
  desc "import files from location"
  task :files, [:path] => :environment do |_task, args|
    files_path = args[:path]
    unless files_path.present? && File.exist?(files_path)
      puts "no files in this path"
      exit(1)
    end

    Dir.glob(files_path).each do |path|
      puts "importing #{path}"
      PipelineJob.perform_later(path)
    end
  end
end
