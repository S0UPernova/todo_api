namespace :docker do
  desc 'Restart Docker containers'
  task :restart do
    on roles(:app) do
      within release_path do
        execute :docker, 'compose', '-f', fetch(:docker_compose_file), 'down'
        execute :docker, 'compose', '-f', fetch(:docker_compose_file), 'up', '-d', '--build'
      end
    end
  end
end

after 'deploy:publishing', 'docker:restart'