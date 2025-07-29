namespace :docker do
  task :build do
    on roles(:app) do
      within release_path do
        execute :docker, 'build', '-t', 'todo_api', '.'
      end
    end
  end
  
  task :restart do
    on roles(:app) do
      execute :docker, 'stop', 'todo_api_container || true'
      execute :docker, 'rm', 'todo_api_container || true'
      execute :docker, 'run', '-d', '--name', 'todo_api_container', 
             '-p', '3000:3000', '--restart', 'unless-stopped', 'todo_api'
    end
  end
  # task :build do
  #   on roles(:app) do
  #     within release_path do
  #       execute :docker, 'compose', '-f', fetch(:docker_compose_file), 'build'
  #     end
  #   end
  # end

  # task :restart do
  #   on roles(:app) do
  #     within release_path do
  #       execute :docker, 'compose', '-f', fetch(:docker_compose_file), 'down'
  #       execute :docker, 'compose', '-f', fetch(:docker_compose_file), 'up', '-d', '--build'
  #     end
  #   end
  # end
end

# Hook into the deployment flow
# after 'deploy:published', 'deploy:docker_build'
# after 'deploy:docker_build', 'deploy:docker_restart'