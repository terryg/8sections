FROM ruby:2.7 as eightsections_server

RUN apt-get update -qq && apt-get install -y build-essential ruby-dev libpq-dev postgresql-server-dev-13

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 9393

CMD ["bundle", "exec", "foreman", "run", "shotgun"]
