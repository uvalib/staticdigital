FROM ruby:2.5.0-alpine3.7

RUN apk upgrade --update \
    && apk add libxml2 libxml2-dev libxml2-utils libxslt libxslt-dev gcc g++ make nodejs tzdata

# export port
EXPOSE 8080

WORKDIR /usr/src/app
COPY Gemfile* ./
RUN gem install --no-document nokogiri -- --use-system-libraries
RUN bundle install
COPY . .

CMD ["rails", "server", "-b", "0.0.0.0" "-p", "8080"]
