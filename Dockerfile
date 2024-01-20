FROM ruby:3.0.3
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
#RUN mkdir /geolocator
WORKDIR /geolocator
COPY Gemfile /geolocator/Gemfile
COPY Gemfile.lock /geolocator/Gemfile.lock
RUN bundle install

#COPY . /geolocator

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
