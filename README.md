# Ruboty::Replace
Replace given message with registered patterns for other handlers.

## Usage
```
@ruboty replace <regexp> with <template> - Register pattern
@ruboty list patterns                    - List registered patterns
@ruboty delete pattern <regexp>          - Delete pattern
```

### Note
You need to put `ruboty-replace` gem before other handlers.

```rb
# Gemfile
gem "ruboty-replace"
gem "ruboty-cron"
gem "ruboty-google_image"
...
```
