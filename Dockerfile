FROM ruby:2.7.1
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client yarn chromium-driver
RUN mkdir /DEPS
WORKDIR /DEPS
COPY Gemfile /DEPS/Gemfile
COPY Gemfile.lock /DEPS/Gemfile.lock
RUN gem install bundler
RUN bundle install
COPY . /DEPS
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]