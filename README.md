# xlsx-locales

Converts [i18next](https://www.i18next.com/) JSON locale files to and from XLSX to enable a simple single language translation workflow.

## Requirements

* Ruby 2.6+

## Example Usage

```bash
# 0. install dependencies
bundle install

# 1. create an xlsx file with 3 columns: key, base string (en), translated string (ko)
bundle exec bin/json2xlsx en.json ko.json en-ko.xlsx

# 2. translator updates en-ko.xlsx -> en-ko-updated.xlsx

# 3. convert 3rd column back to a json file (also outputs en.json, but typically that can be ignored)
bundle exec bin/xlsx2json en-ko-updated.xlsx en-updated.json ko-updated.json

# 4. merge updated ko.json back into original
bundle exec bin/json2json ko.json ko-updated.json ko-final.json
```
