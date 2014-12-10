# webpage

This is a general web page scaffold written in Haskell for the 
[Lucid](https://github.com/chrisdone/lucid) Html DSL.

## Usage

It's pretty straigt forward:

```haskell
λ> renderText $ template mempty "some content"

"<!DOCTYPE HTML><html><head><title></title><link href rel="icon"></head><body>some content</body></html>"
```

overload the particular areas with record syntax, or do whatever:

```haskell
λ> let page = mempty {pageTitle = "foo", bodyScripts = script_ [src_ "jquery.js"] ""}

λ> template page "some content"

"<!DOCTYPE HTML><html><head><title>foo</title><link href rel=\"icon\"></head><body>some content<script src=\"jquery.js\"></script></body></html>"
```

## Contributing

Fork, Pull-Request, repeat.
