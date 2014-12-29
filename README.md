# webpage

This is a general web page scaffold written in Haskell for the
[Lucid](https://github.com/chrisdone/lucid) Html DSL.

## Usage

It's pretty straigt forward:

```haskell
λ> renderText $ template def "some content"

"<!DOCTYPE HTML><html><head><title></title><link href rel="icon"></head><body>some content</body></html>"
```

overload the particular areas with record syntax, or do whatever:

```haskell
λ> let page = def {pageTitle = "foo", bodyScripts = script_ [src_ "jquery.js"] ""}

λ> template page "some content"

"<!DOCTYPE HTML><html><head><title>foo</title><link href rel=\"icon\"></head><body>some content<script src=\"jquery.js\"></script></body></html>"
```

> **Note**: When using the [Hastache](http://hackage.haskell.org/package/hastache)
> implementation, the content inside a `WebPage` data type will be in the same
> scope as the rest of the template - you can access the things your final
> content will see from `metaVars`, for instance (unless you do multiple
> renderings).

> **Another Note**: We don't provide an instance for the beloved
[Hamlet](http://hackage.haskell.org/package/shakespeare)
> because under the hood, it's just Blaze-Html -
>`$(runQ $ shamletFile "foo.hamlet")` gives us an `Html`.

## Contributing

Fork, Pull-Request, repeat.
