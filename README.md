middleman-backtick
==================

backtick_code_blocks (like octopress') for middleman

===

## QUICK START

### Step 1

Edit `Gemfile`, and add:

    gem "middleman-deploy", :github => 'LeonB/middleman-backtick'

Then run:

    bundle install

### Step 2 - Middleman setup

```
activate :backtick_code_block
```

### SYNTAX

    ```
    [language] [title] [url] [link text]
    code snippet
    ```

### EXAMPLE

![Example of figcaption](https://raw.github.com/LeonB/middleman-backtick/master/figcaption_example.png)

### NOTES

Inspired by the [Octopress plugin](http://octopress.org/docs/plugins/backtick-codeblock/)
