FROM arm64v8/ruby:2.7.5-bullseye

# 1. First upgrade RubyGems before anything else
RUN gem update --system 3.3.22 && \
    gem install bundler -v 2.4.22

# 2. Install dependencies
RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends \
        build-essential \
            libpq-dev \
                nodejs \
                    yarn \
                    rails \
                        # Required for native extensions
                            pkg-config \
                                libffi-dev \
                                    && rm -rf /var/lib/apt/lists/*

# 3. Configure bundler
ENV BUNDLE_JOBS=2 \
    BUNDLE_RETRY=5 \
        BUNDLE_PATH=/usr/local/bundle

        WORKDIR /app

# 4. Copy Gemfiles first for caching
COPY Gemfile ./

# 5. Install gems with platform fix
RUN bundle _2.4.22_ install \
    --without development test \
        --jobs=2 \
            --retry=5

# 6. Copy application
COPY . .

# 7. Entrypoint
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
