FROM ruby:2.6.3
WORKDIR /bowerbird-test/
COPY . /bowerbird-test/
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -; \
  apt-get install -y nodejs nano; \
  mv entrypoint.sh /usr/bin/entrypoint; \
  chmod +x /usr/bin/entrypoint; \
  gem install bundler:2.2.18; \
  bundle install -j 12; \
  npm install --global yarn; \
  yarn install;
ENTRYPOINT [ "entrypoint" ]
