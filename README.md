## Description of geolocator
It's REST API which locates and stores location basing on IP.

## Code style

Rubocop

## Built with:

- [Ruby 3.0.3](https://www.ruby-lang.org/en/)
- [Ruby on Rails 7.0.8](https://rubyonrails.org/)
- [PostgreSQL 14.4](https://www.postgresql.org/)
- [Redis 7.2-alpine](https://redis.io/)
- [Docker 24.0.7](https://www.docker.com/)

## Installing

```sh
$ git clone https://github.com/KacperMekarski/geolocator.git

$ cd geolocator

$ docker compose build

$ docker compose run web rake db:setup

$ docker compose up

You can run tests with:
$ docker compose run web bundle exec rspec spec

Stop application with:
$ docker compose down
```

## Author

* [Kacper Mekarski](https://github.com/KacperMekarski)

## License

MIT © [Kacper Mękarski](https://github.com/KacperMekarski)
