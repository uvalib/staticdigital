FROM ruby:2.5.0-alpine3.7

# update packages
RUN apk upgrade --update && apk add libxml2 libxml2-dev libxml2-utils libxslt libxslt-dev gcc g++ make nodejs tzdata bash

# export port
EXPOSE 8080

# working directory
WORKDIR /usr/src/app

# copy Gemfile and install dependancies
COPY Gemfile* ./
RUN bundle install --jobs=4 --without=["development" "test"] --no-cache

# copt application
COPY . .

# precompile the assets for production mode
RUN RAILS_ENV=production SECRET_KEY_BASE=x bundle exec rake assets:precompile

# run
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0", "-p", "8080", "Puma"]

#
# end of file
#
