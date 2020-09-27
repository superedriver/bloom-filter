require './lib/bloom_filter'

RSpec.describe BloomFilter::Filter do
  describe "hash functions size and bitset size" do
    it "default values" do
      bf = BloomFilter::Filter.new
      expect(bf.instance_variable_get(:@m)).to eq(959)
      expect(bf.instance_variable_get(:@k)).to eq(7)
    end

    it "not default values" do
      bf = BloomFilter::Filter.new(1000, 0.001)
      expect(bf.instance_variable_get(:@m)).to eq(14_378)
      expect(bf.instance_variable_get(:@k)).to eq(10)
    end
  end

  describe "adding values" do
    it "before inserting value" do
      value = 'test'
      bf = BloomFilter::Filter.new
      expect(bf.includes?(value)).to eq(false)
      expect(bf.count).to eq(0)
    end

    it "after inserting value" do
      value = 'test'
      bf = BloomFilter::Filter.new
      bf.add(value)
      expect(bf.includes?(value)).to eq(true)
      expect(bf.count).to eq(1)
    end

    it "inserting the same value" do
      value = 'test'
      bf = BloomFilter::Filter.new
      bf.add(value)
      bf.add(value)
      expect(bf.includes?(value)).to eq(true)
      expect(bf.count).to eq(1)
    end
  end

  describe "if value presents" do
    it "does not present" do
      value = 'test'
      bf = BloomFilter::Filter.new
      expect(bf.includes?(value)).to eq(false)
    end

    it "presents" do
      value = 'test'
      bf = BloomFilter::Filter.new
      bf.add(value)
      expect(bf.includes?(value)).to eq(true)
    end
  end

  describe "count" do
    it "empty bitset" do
      bf = BloomFilter::Filter.new
      expect(bf.count).to eq(0)
    end

    it "5 insertions" do
      bf = BloomFilter::Filter.new
      bf.add('test1')
      bf.add('test2')
      bf.add('test3')
      bf.add('test4')
      bf.add('test5')
      expect(bf.count).to eq(5)
    end
  end
end
