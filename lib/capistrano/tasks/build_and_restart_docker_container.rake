namespace :deploy do
  desc "Build the Docker  container  and restart (run this after the deploy tasks are complete)"
  task :build_and_restart_docker_container do
    on roles(:web) do |host|
      within(File.join(fetch(:deploy_to), 'current')) do
        info "docker compose build on #{host}"
        execute(*%w[docker compose build])

        info "docker compose up -d db (Make sure the database container is up)"
        execute(*%w[docker compose up -d db])
        
        info "docker compose run feb bundle exec rake db:create db:migrate on #{host}"
        execute(*%[docker compose run web bundle exec rake db:create db:migrate])

        info "docker compose restart on  #{host}"
        execute(*%[docker compose -f docker-compose-yml -f docker-compose.prod.yml --no-deps -d restart web])
      end
    end
  end
end
