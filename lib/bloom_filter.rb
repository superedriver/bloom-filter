require "bloom_filter/version"
require "bitset"
require 'digest/md5'

module BloomFilter
  PRIME = 100_000_000_003
  MAX_HASH_PARAM = 1000
  class Filter
    attr_reader :count

    def initialize(capacity = 100, probability = 0.01)
      # amount of inserted elements
      @count = 0

      #number of bits in the array
      @m = (-(capacity * Math.log(probability)) / (Math.log(2) ** 2)).ceil

      @bitset = Bitset.new(@m)

      #number of hash functions that minimizes the probability of false positives
      @k = (Math.log(2) * (@m / capacity)).ceil

      # a, b params for hash functions
      @hash_params = []
      @k.times { @hash_params.push([rand(1000), rand(1000)]) }
    end

    def add(value)
      x = get_hash(value)
      was_inserted = true
      @k.times do |i|
        a, b = @hash_params[i]
        position = get_position(a, b, x)
        was_inserted = false unless @bitset[position]
        @bitset[position] = true
      end
      @count += 1 unless was_inserted
      value
    end

    def contains?(value)
      x = get_hash(value)
      result = true
      @k.times do |i|
        a, b = @hash_params[i]
        result = false unless @bitset[get_position(a, b, x)]
      end

      result
    end
    alias :includes? :contains?

    private

    def get_position(a, b, val)
      ((a * val + b) % PRIME) % @m
    end

    def get_hash(value)
      Digest::MD5.hexdigest(value.to_s).to_i(16)
    end
  end
end
