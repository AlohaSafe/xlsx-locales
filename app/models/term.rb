# frozen_string_literal: true

require 'json'

class Term
  attr_accessor :key, :base, :translated

  def initialize(key: nil, base: nil, translated: nil)
    self.key = key
    self.base = base
    self.translated = translated
  end

  def ==(other)
    [key, base, translated] == [other.key, other.base, other.translated]
  end

  def merge!(other)
    return self unless key == other.key

    self.base = other.base if other.base.presence
    self.translated = other.translated if other.translated.presence

    self
  end

  def self.human_attribute_name(attr)
    attr.to_s.capitalize
  end

  def self.read_parse_merge(enfile, otherfile)
    merge(parse_base(File.read(enfile)), parse_translated(File.read(otherfile)))
  end

  def self.parse_base(json_str)
    parse(json_str, :base)
  end

  def self.parse_translated(json_str)
    parse(json_str, :translated)
  end

  def self.parse(json_str, base_or_translated)
    hash = JSON.parse(json_str)

    # returns array of Terms
    flatten_hash(hash).to_a.map do |pair|
      k, v = pair
      case base_or_translated
      when :base then Term.new(key: k, base: v)
      when :translated then Term.new(key: k, translated: v)
      end
    end
  end

  # recurses through hash and creates a single-level hash with hierarchical keys
  def self.flatten_hash(hash, prefix: '', separator: '.')
    new_hash = {}
    hash.each do |k, v|
      case v
      when Hash then new_hash.merge!(flatten_hash(v, prefix: "#{prefix}#{k}.", separator: separator))
      else new_hash["#{prefix}#{k}"] = v
      end
    end
    new_hash
  end

  def self.merge(en_terms, other_terms)
    hash = en_terms.map { |t| [t.key, t] }.to_h

    other_terms.each do |t|
      if hash[t.key]
        hash[t.key].merge!(t)
      else
        hash[t.key] = t
      end
    end

    hash.values
  end

  def self.array_to_hierarchical_base_json(terms, separator: '.', pretty: true)
    array_to_hierarchical_json(terms, :base, separator: separator, pretty: pretty)
  end

  def self.array_to_hierarchical_translated_json(terms, separator: '.', pretty: true)
    array_to_hierarchical_json(terms, :translated, separator: separator, pretty: pretty)
  end

  def self.array_to_hierarchical_json(terms, base_or_translated, separator: '.', pretty: true)
    hash = {}

    terms.each do |t|
      next unless (val = t.send(base_or_translated))

      parts = t.key.split(separator)
      hash.deep_merge! parts.reverse.reduce(val) { |acc, key| { key => acc } }
    end

    JSON.send(pretty ? :pretty_generate : :generate, hash)
  end
end
