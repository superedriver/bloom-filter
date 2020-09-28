require "bloom_filter/version"
require "bitset"
require 'digest/md5'

module BloomFilter
  PRIME = 100_000_000_003
  MAX_HASH_PARAM = 1000
  OUT_OF_RANGE = "Position is out of range"

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
    end

    def add(value)
      x = get_hash(value)
      was_inserted = true
      @k.times do |i|
        a, b = get_hash_params(i)
        position = get_position(a, b, x)
        was_inserted = false unless self.get_bit(position)
        self.set_bit(position)
      end
      @count += 1 unless was_inserted
      value
    end

    def contains?(value)
      x = get_hash(value)
      result = true
      @k.times do |i|
        a, b = get_hash_params(i)
        result = false unless self.get_bit(get_position(a, b, x))
      end

      result
    end
    alias :includes? :contains?

    def get_bit(position)
      @bitset[position] if is_valid_position(position)
    end

    def set_bit(position)
      @bitset[position] = true if is_valid_position(position)
    end

    def clear_bit(position)
      @bitset[position] = false if is_valid_position(position)
    end

    def bit_size
      @m
    end

    private

    def get_position(a, b, val)
      ((a * val + b) % PRIME) % @m
    end

    def get_hash(value)
      Digest::MD5.hexdigest(value.to_s).to_i(16)
    end

    def is_valid_position(position)
      raise OUT_OF_RANGE if position >= @m
      true
    end

    def get_hash_params(i)
      return 2*i + 1, 2*i + 2
    end
  end
end
