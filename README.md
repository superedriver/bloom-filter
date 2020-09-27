# BloomFilter

A Bloom filter is a space-efficient probabilistic data structure
[Wiki](https://en.wikipedia.org/wiki/Bloom_filter)
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bloom_filter'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install bloom_filter

## Usage

After installation the instance can be created. 
And two parameters can be used to describe the bloom filter: 

* first - number of items that are be inserted(default: 100)
* second - False Positive probability(default: 0.01)

```ruby
bloom_filter = BloomFilter::Filter.new(1000, 0.001)
```

#### API
__add(value)__ - add item into filter

__includes?(value)__ - check if filter includes the value

__contains?(value)__ - alias of __includes?(value)__

__count__ - returns number of inserted items

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/superedriver/bloom_filter

