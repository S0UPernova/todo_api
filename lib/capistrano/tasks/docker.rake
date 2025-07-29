namespace :docker do
  # task :build do
  #   on roles(:app) do
  #     within release_path do
  #       execute :docker, 'compose', 'build'
  #     end
  #   end
  # end
  
  # task :restart do
  #   on roles(:app) do
  #     execute :docker, 'stop', 'todo_api_container || true'
  #     execute :docker, 'rm', 'todo_api_container || true'
  #     execute :docker, 'run', '-d', '--name', 'todo_api_container', 
  #            '-p', '3000:3000', '--restart', 'unless-stopped', 'todo_api'
  #   end
  # end
  task :build do
    on roles(:app) do
      within current_path do
        execute :docker, :compose, '-f', fetch(:docker_compose_file), 'build'
      end
    end
  end

  task :restart do
    on roles(:app) do
      within current_path do
        execute :docker, :compose, '-f', fetch(:docker_compose_file), 'down -v --remove-orphans'
        execute :docker, :compose, '-f', fetch(:docker_compose_file), 'up', '-d'
      end
    end
  end
end

# Hook into the deployment flow
after 'deploy:published', 'docker:build'
after 'docker:build', 'docker:restart'