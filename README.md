# FunctionalSupport

A collection of higher order functional methods to arrays and hashes that I found useful from my various projects and decided to compile into a gem here.

# Arrays

> uniq_merge
```ruby
[{id: 1, values: [13] }, { id: 2, values: [11, 12]}, {id: 1, values: [10] }].uniq_merge do |hash|
  hash[:id]
end.call do |hash_a, hash_b|
  hash_a[:values] += hash_b[:values]
  hash_a
end
```

# Hashes

## Installation

Add this line to your application's Gemfile:

    gem 'functional_support'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install functional_support

## Usage

TODO: Write usage instructions here

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
