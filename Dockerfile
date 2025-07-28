FROM arm64v8/ruby:2.7.2
RUN mkdir /app
WORKDIR /app
# 2. Install dependencies
#RUN apt-get update -qq && \
  #  apt-get install -y \
  #  build-essential \
    #postgresql-client libffi-dev libxml2-dev libxslt1-dev && \
    #&& \
RUN    rm -rf /var/lib/apt/lists/*


# 3. Configure bundler
RUN gem update --system 3.3.22 && \
    gem install bundler -v 2.4.22

#ENV BUNDLE_WITHOUT="development test"
# 4. Copy Gemfiles first for caching

COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
# 5. Install gems with platform fix
RUN bundle config set force_ruby_platform true
RUN bundle lock --add-platform x86_64-linux

RUN bundle _2.4.22_ install \
        --jobs=2 \
            --retry=5
COPY . /app

ENV RAILS_SERVE_STATIC_FILES=true
RUN rails assets:precompile
RUN rails db:migrate
EXPOSE 3000
CMD ["bash"]
# 6. Copy application
# Precompile assets
#RUN bundle exec rails assets:precompile

# 7. Entrypoint
# COPY entrypoint.sh /usr/bin/
# RUN chmod +x /usr/bin/entrypoint.sh
# ENTRYPOINT ["entrypoint.sh"]

# 8. Run the server.
#CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
#CMD ["rails", "server"]
