# Taric

[![Gem Version](https://badge.fury.io/rb/taric.svg)](http://badge.fury.io/rb/taric)
[![Code Climate](https://codeclimate.com/github/josephyi/taric/badges/gpa.svg)](https://codeclimate.com/github/josephyi/taric)
[![Build Status](https://travis-ci.org/josephyi/taric.svg?branch=master)](https://travis-ci.org/josephyi/taric)
[![Coverage Status](https://coveralls.io/repos/josephyi/taric/badge.svg?branch=master)](https://coveralls.io/r/josephyi/taric?branch=master)
[![Inline docs](http://inch-ci.org/github/josephyi/taric.svg?branch=master)](http://inch-ci.org/github/josephyi/taric)

> "Ruby for vigor."

Taric is a Ruby interface to Riot Games' League of Legends API.

## Prerequisite

> "You face unblemished power."

Sign up for an API key at [Riot Games Developer] site.

## Installation

> "Gems? Gems are truly outrageous. They are truly, truly, truly outrageous."

Add this line to your application's Gemfile:

```ruby
gem 'taric'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install taric

## API Support

> "What did I see upon the mountain? Rocks. Lots of rocks."

- [x] CHAMPION-V3
- [x] CHAMPION-MASTERY-V3
- [x] LEAGUE-V2.5
- [x] LOL-STATUS-V3
- [x] MASTERIES-V3
- [x] MATCH-V3
- [x] RUNES-V3
- [x] SPECTATOR-V3
- [ ] STATIC-DATA-V3
- [x] SUMMONER-V3
- [x] ~~CURRENT-GAME-V1.0~~ replaced by SPECTATOR-V3
- [x] ~~FEATURED-GAMES-V1.0~~ replaced by SPECTATOR-V3
- [x] ~~GAME-V1.3~~ replaced by MATCH-V3
- [x] ~~LOL-STATIC-DATA-V1.2~~ replaced by STATIC-DATA-V3
- [x] ~~LOL-STATUS-V1.0~~ replaced by LOL-STATUS-V3
- [x] ~~MATCH-V2.2~~ replaced by MATCH-V3
- [x] ~~MATCHLIST-V2.2~~ replaced by MATCH-V3
- [x] ~~RUNES-MASTERIES-V1.4~~ replaced by RUNES-V3 AND MASTERIES-V3
- [x] ~~CHAMPION-V1.2~~ replaced by CHAMPION-V3
- [x] ~~CHAMPIONMASTERY~~ replaced by CHAMPION-MASTERY-V3
- [x] ~~STATS-V1.3~~ no replacement
- [x] ~~SUMMONER-V1.4~~ replaced by SUMMONER-V3

## Configuration

> "With clarity."

There are a couple of ways to set the API key:

1. Set the `RIOT_API_KEY` environment variable:

    ```
    RIOT_API_KEY=whatever_key_rito_assigned_you
    ```

    This approach is best if you don't care to configure anything else.

2. Configure it once (e.g. Rails initializer). An example with typhoeus:

    ```ruby
    require 'faraday'
    require 'typhoeus'
    require 'typhoeus/adapters/faraday'

    Taric.configure! do |config|
      config.api_key = 'whatever_key_rito_assigned_you'
      config.adapter = :typhoeus # default is Faraday.default_adapter
    end
    ```

    This approach is best if you want to configure other things (documentation to come)



## Usage

> "Functional and stylish."

Once the key is set, you can use `Taric.client(region: region_code)` to get a client instance for the specified region.

```ruby
# North America
client = Taric.client(region: :na)

# Korea, using String arg
client = Taric.client(region: 'kr')
```

Taric also supports parallel HTTP requests via Typhoeus.

```ruby
# Be sure to include the adapter
require 'typhoeus/adapters/faraday'

# from regular client...
client = Taric.client(region: :na)

# ...to parallel mode. Just chain the operation methods
parallel_client = client.in_parallel.match(id: 1).match(id: 42)

# When you're ready, execute! Note, this clears the operations.
# By default each response returns a hash with HTTP status
# and body e.g. {status: 200, body: [1778689691]}
responses = parallel_client.execute!
```

### Champion

```ruby
# https://developer.riotgames.com/api/methods#!/958/3289
client.champion(id: )

# https://developer.riotgames.com/api/methods#!/958/3290
client.champions
```

### Current Game

```ruby
# https://developer.riotgames.com/api/methods#!/956/3287
client.current_game(summoner_id: )
```

### Featured Games

```ruby
# https://developer.riotgames.com/api/methods#!/957/3288
client.featured_games
```

TODO: finish writing this crap :p

## Development

> "I will weep for you."

After checking out the repo, run `bin/setup` to install dependencies. Then, run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release` to create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

> "Brilliantly."

1. Fork it ( https://github.com/josephyi/taric/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[Riot Games Developer]:https://developer.riotgames.com/
