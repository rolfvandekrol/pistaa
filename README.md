# Pistaa

Simple structure for Ruby on Rails that allows templates for engines to accept 
injected content from other engines.

Suppose you are creating a modular product that consists of a main engine and
some engines that can be used to extend the main engine. When some of the
optional engines are enabled, you probably want to alter a template in the main
engine, to show functionality that is included in one of the optional engines.
But if you change the main engine to cater the needs of all optional engine, the
main engine becomes a spaghetti of code for the optional engines.

Pistaa provides another solution to this problem. It allows you to define 
*slots* where other engines can inject *partials* so your main engine only has
to call Pistaa to render a slot and automatically all injected partials will be
rendered.

## Usage

Add Pistaa to the `gemspec` of your main engine.

```ruby
s.add_dependency "pistaa"
```

Change a template in the main engine to render a *slot* where other engines can
inject *partials*. So let's change `news/show.html.erb`.

```erb
<%= render_pistaa_slot :news_body %>
```

Then, in one of the optional engines, register a *partial* in the *slot*.

```ruby
module MyEngine
  class Engine < ::Rails::Engine
    def self.activate
      Pistaa[:news_body][:my_engine_content] = 'my_engine/news/my_engine_content'
    end

    config.to_prepare &method(:activate).to_proc
  end
end
```

And make sure the template `my_engine/news/_my_engine_content.html.erb` exists. 
This will be rendered just like any other partial, so you can use all the 
instance variables that are available to the template in the main engine.

Because Pistaa does not hijack the rendering logic in any way (it only provides
simple helpers that loop over the *partials* in a *slot* and calls
`render partial: 'path/to/partial'` for each partial), all functionality that
Rails uses for rendering views is still available. So you can render other 
partials for the injected partial, you can use any template language you like
and you can even call Pistaa again from the injected partial.

Because it essentially is simple partial rendering, overriding templates also
works as expected. So if the application that uses both the main engine and
MyEngine defines `my_engine/news/_my_engine_content.html.erb`, it will override
the template from MyEngine.

If the main application overrides the template `news/show.html.erb`, Pistaa
exposes some helpers that allow the overriding template to control the order of
the partials in the slot. Check `app/helpers/pistaa_helper.rb` for more 
information. Smart combination of `render_pistaa_slot`, 
`render_pistaa_slot_item` and `hide_pistaa_slot_item` will probably serve your
needs.

## Inspiration

I'm aware of one other project that tries to solve this problem, but in a
completely different way. [Deface](https://github.com/spree/deface) is tool that
was used in older versions of [Spree](https://spreecommerce.com/) and also 
provides a way to alter templates from engines. It parses ERB templates to an
XML structure using Nokogiri, exposes a DSL to manipulate the Nokogiri document
and renders the document back to ERB. Although it works, it is quite error
prone. Currently, it's stable versions only support Rails 3.

The way `hide_pistaa_slot_item`, `render_pistaa_slot_item` and 
`render_pistaa_slot` work, is inspired by [Drupal](https://drupal.org/)'s render
arrays.

## Roadmap

The first thing that will be added to this gem, is a way to control the order
of the partials from the engines.
