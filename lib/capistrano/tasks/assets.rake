namespace :deploy do
  task :precompile_assets do
    run_locally do
      # 1. Clean existing assets
      execute :rm, '-rf', 'public/assets'
      execute :rm, '-rf', 'public/packs' if File.directory?('public/packs')
      
      # 2. Precompile locally
      with rails_env: :production do
        execute :bundle, :exec, :rake, 'assets:precompile'
      end
      
      # 3. Create archive with only existing directories
      assets_to_archive = ['public/assets']
      assets_to_archive << 'public/packs' if File.directory?('public/packs')
      
      execute :tar, '-czf', 'assets.tar.gz', *assets_to_archive
      
      # 4. Upload and extract
      on roles(:app) do
        upload! 'assets.tar.gz', "#{release_path}/assets.tar.gz"
        within release_path do
          execute :mkdir, '-p', 'public'
          execute :tar, '-xzf', 'assets.tar.gz', '-C', '.'
          execute :rm, 'assets.tar.gz'
        end
      end
      
      # 5. Clean up
      execute :rm, 'assets.tar.gz'
      execute :rm, '-rf', 'public/assets'
      execute :rm, '-rf', 'public/packs' if File.directory?('public/packs')
    end
  end
end

before 'deploy:updated', 'deploy:precompile_assets'