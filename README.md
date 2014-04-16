# Seeker

This Ruby on Rails gem provides an elegant way to separate search logic out of models
and build search forms just like create/update ones.

Right now it supports only [sunspot](https://github.com/sunspot/sunspot) and was tested on Rails 3.2.13.

## Installation

    gem 'seeker'

## Usage

Given you have Product model:

```ruby
class Product < ActiveRecord::Base
  mount_searcher ProductSearcher
end
```

Create corresponding searcher:

```ruby
# app/searchers/product_searcher.rb
class ProductSearcher < Seeker::Base
  attr_accessor :name, :max_price

  searchable do
    text :name
    integer :price
  end

  def search(query)
    query.fulltext(:name, @name) if @name.present?
    query.with(:price).less_than_or_equal_to(@max_price) if @max_price.present?
  end
end
```

Use it in your controller:

```ruby
class ProductsController < ApplicationController
  def index
    @searcher = Product.searcher params[:product]
  end
end
```

And use it in your view with form helper, just like model:

```slim
# app/views/products/index.html.slim
= form_for @searcher do |f|
  = f.label :name
  = f.text_field :name

  = f.label :max_price
  = f.number_field :max_price

  = f.submit

h1 Search results
ul
  = @searcher.results.each do |product|
    li #{product.name} - #{product.price}
```

## TODO

* add tests
* add support for [ThinkingSphinx](https://github.com/pat/thinking-sphinx)
