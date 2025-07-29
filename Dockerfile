FROM arm64v8/ruby:2.7.2
# 1. Setup directory
RUN mkdir /app
WORKDIR /app
# 2. Update to use archived repositories and install dependencies
RUN sed -i 's|deb.debian.org|archive.debian.org|g' /etc/apt/sources.list && \
    sed -i 's|security.debian.org|archive.debian.org/debian-security|g' /etc/apt/sources.list && \
    apt-get update -qq && \
    apt-get install -y postgresql-client && \
    rm -rf /var/lib/apt/lists/*


# 3. Configure bundler
RUN gem update --system 3.3.22 && \
    gem install bundler -v 2.4.22

# might try readding this
#ENV BUNDLE_WITHOUT="development test"

# 4. Copy Gemfiles first for caching
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
# 5. Install gems with platform fix
RUN bundle config set force_ruby_platform true
RUN bundle lock --add-platform x86_64-linux

# 6. Install gems
RUN bundle _2.4.22_ install \
        --jobs=2 \
            --retry=5
COPY . /app

ENV RAILS_SERVE_STATIC_FILES=true
# RUN rails assets:precompile
# RUN rails db:migrate
COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]