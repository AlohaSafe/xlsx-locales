# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Term do
  context 'basics' do
    it 'has basic attributes' do
      term = Term.new(key: 'key', base: 'base', translated: 'translated')
      expect(term.key).to eq 'key'
      expect(term.base).to eq 'base'
      expect(term.translated).to eq 'translated'
    end
  end

  context '.flatten_hash' do
    it 'converts a hierarchical hash into a single-level hash with hierarchical keys' do
      hash1 = { 'category' => { 'key' => 'asdf' } }
      hash2 = { 'category.key' => 'asdf' }
      expect(Term.flatten_hash(hash1)).to eq hash2
    end
  end

  context '.parse' do
    it 'parses a JSON string representing a hierarchical hash into a flat array of Terms with hierarchical keys' do
      terms = [Term.new(key: 'key', base: 'asdf')]
      expect(Term.parse('{"key":"asdf"}', :base)).to eq terms
      terms = [Term.new(key: 'category.key', base: 'asdf')]
      expect(Term.parse('{"category":{"key":"asdf"}}', :base)).to eq terms
    end
  end

  context '.merge' do
    it 'merges two lists of Terms into one' do
      terms1 = [Term.new(key: 'key', base: 'asdf')]
      terms2 = [Term.new(key: 'key', translated: 'fdsa')]
      terms3 = [Term.new(key: 'key', base: 'asdf', translated: 'fdsa')]
      expect(Term.merge(terms1, terms2)).to eq terms3
    end
  end

  context '.array_to_hierarchical_json' do
    it 'encodes a flat array of Terms with hierarchical keys into a JSON string representing a hierarchical hash' do
      terms = [Term.new(key: 'key', base: 'asdf')]
      expect(Term.array_to_hierarchical_json(terms, :base)).to eq '{"key":"asdf"}'
      terms = [Term.new(key: 'category.key', base: 'asdf')]
      expect(Term.array_to_hierarchical_json(terms, :base)).to eq '{"category":{"key":"asdf"}}'
    end
  end
end
