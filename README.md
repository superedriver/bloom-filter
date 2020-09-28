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

#### Methods
__add(value)__ - add item into filter

__includes?(value)__ - check if filter includes the value

__contains?(value)__ - alias of __includes?(value)__

__count__ - returns number of inserted items

##### Methods for union and intersection several bloom filters

__bit_size__ - returns number of bits in the bit array

__get_bit(position)__ - returns value of a bit(true/false) in the bit array, rises an error if position is out of range of the bit array

__set_bit(position)__ - set a bit to TRUE in the bit array, rises an error if position is out of range of the bit array

__clear_bit(position)__ - set a bit to FALSE in the bit array, rises an error if position is out of range of the bit array

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/superedriver/bloom_filter

