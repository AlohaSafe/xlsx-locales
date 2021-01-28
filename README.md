# xlsx-locales

For use with [PathCheck's GAEN app](https://github.com/Path-Check/gaen-mobile). Converts JSON locale files to and from XLSX to enable translation workflow.

## Requirements

* Ruby 2.6+

## Usage

```bash
bundle install

bundle exec bin/json2xlsx <en-json-filename> <other-json-filename> <output-filename>

bundle exec bin/xlsx2json <xlsx-filename> <output-en-json-filename> <output-other-json-filename>
```
