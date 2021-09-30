FROM ruby:2.5 as server

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev postgresql-server-dev-11

RUN bundle config --global frozen 1

WORKDIR /usr/src/app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 9393

CMD ["bundle", "exec", "foreman", "run", "shotgun"]
