namespace :copy_files do
  desc 'Copy files to server and maintain directory structure'
  task :copy do
    on roles(:app) do
      fetch(:copy_files).each do |file|
        # Determine target path (preserve directory structure)
        target_path = File.join(fetch(:copy_target), File.dirname(file))
        
        # Create target directory if needed
        execute :mkdir, '-p', target_path unless File.dirname(file) == '.'
        
        # Upload the file
        upload! file, File.join(target_path, File.basename(file))
      end
    end
  end
end