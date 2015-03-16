[![Code Climate](https://codeclimate.com/github/josephyi/taric/badges/gpa.svg)](https://codeclimate.com/github/josephyi/taric)

# Taric

> "Ruby for vigor."

Taric is a wrapper client to Riot Games' League of Legends API.

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

## Configuration

> "With clarity."

There are a couple of ways to set the API key:

1. Set the `RIOT_API_KEY` environment variable:

    ```
    RIOT_API_KEY=whatever_key_rito_assigned_you
    ```

    This approach is best if you don't care to configure anything else.

2. Configure it once (e.g. Rails initializer):

    ```ruby
    Taric.configure! do |config|
      config.api_key = 'whatever_key_rito_assigned_you'
    end
    ```

    This approach is best if you want to configure other things (documentation to come)

## Usage

> "Functional and stylish."

Once the key is set, you can use `Taric.client(:region)` to get a client instance for the specified region.

```ruby
# North America
client = Taric.client(:na)

# Korea
client = Taric.client(:kr)
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

> ""Brilliantly."

1. Fork it ( https://github.com/[my-github-username]/taric/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

[Riot Games Developer]:https://developer.riotgames.com/