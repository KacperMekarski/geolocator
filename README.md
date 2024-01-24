## Description of geolocator
It's REST API which locates and stores location basing on IP or URL.

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

Download master.key file and place it in config directory. File was given in email with link to this repo)

$ docker compose build

$ docker compose run web rake db:setup

$ docker compose up

You can run tests with:
$ docker compose run web bundle exec rspec spec

Stop application with:
$ docker compose down
```

## API Documentation
Sorry for such documentation, I know it should be done with swagger or something but I didn't have time for it.
### IP
Provide geolocation data based on IP address:
<br>
GET /api/ip_addresses/20.199.210.196
<br>

Delete geolocation data based on IP address:
<br>
DELETE /api/ip_addresses/20.199.210.196
<br>

Add geolocation data based on IP address:
<br>
POST /api/ip_addresses, body: { 'ip': '20.199.210.196' }

### URL
Please note URL should be encoded.

Provide geolocation data based on URL address:
<br>
GET /api/domains?url=https://google.com
<br>

Delete geolocation data based on URL address:
<br>
DELETE /api/domains?url=https://google.com
<br>

Add geolocation data based on URL address:
<br>
POST /api/domains, body: { 'url': 'https://google.com' }

## Author

* [Kacper Mekarski](https://github.com/KacperMekarski)

## License

MIT © [Kacper Mękarski](https://github.com/KacperMekarski)
