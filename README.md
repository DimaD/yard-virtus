# yard-virtus


This gem helps to generate YARD documentation for classes built using [Virtus](https://github.com/solnic/virtus). It extracts information about attributes, their types and writers so you don't need to specify it manually.

This gem depends on exact details of implementation of Virtus so it's locked to a particular version. In the future I wan to adapt versioning scheme for this gem which will reflect supported Virtus version.

## Install

Add the gem to your Gemfile (inside development or documentation group):

``` ruby
  gem "yard-virtus", "= 0.0.4"
```

## Usage

If you use YARD via Rake and `YARD::Rake::YardocTask` or via custom ruby script add

``` ruby
  require "yard-virtus"
```

If you use YARD command line tool use `--plugin` switch like this

```shell
 yard --plugin virtus
```

### Workaround for UndocumentableError Warnings

Standard YARD mixin handler throws `UndocumentableError` when it encounters
mixin which uses method call (like `include Virtus.model`). It serves as a warning
and does not break parsing process but it could be annoying if you have a lot
of Virtus based models. This gem includes mokey-patch for `YARD::Handlers::Ruby::MixinHandler`.
It is not loaded by default and you need to do it explicitly in your Rakefile with:

```ruby
  require "yard/virtus/mixin_handler_monkey_patch"
```

## Work in Progress

This library is still work in progress and is not recommended for production use.

### TODO

* Detect if class gets virtus functionality via inheritance (partially done).
* Attach documentation about various features inherited from Virtus to namespaces.
* Extract default values of attributes.

## Notice

This library uses eval with $SAFE level 3 to evaluate list of options in
`attribute` declarations. Setting $SAFE to level 3 means it can not do
destructive operations on your file system but it can damage objects which
are already in memory.

### Author

[Dmitry Dzema](https://github.com/DimaD) ([@dzema](https://twitter.com/dzema))
