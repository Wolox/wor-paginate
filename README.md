Wor::Paginate
=============

[![Build Status](https://travis-ci.org/Wolox/wor-paginate.svg?branch=master)](https://travis-ci.org/Wolox/wor-paginate)
[![Gem Version](https://badge.fury.io/rb/wor-paginate.svg)](https://badge.fury.io/rb/wor-paginate)
[![Code Climate](https://codeclimate.com/github/Wolox/wor-paginate/badges/gpa.svg)](https://codeclimate.com/github/Wolox/wor-paginate)

# Table of contents
  - [Description](#description)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Basic usage](#basic-usage)
    - [Customizing output](#customizing-output)
      - [Custom serializers](#custom-serializers)
      - [Custom options](#custom-options)
      - [Custom formatters](#custom-formatters)
      - [Custom adapters](#custom-adapters)
    - [Working with Kaminari or will_paginate](#working-with-kaminari-or-will_paginate)
    - [Test helpers](#test-helpers)
  - [Contributing](#contributing)
  - [Releases](#releases)
  - [About](#about)
  - [License](#license)

-----------------------

## Description

Wor::Paginate is a gem for Rails that simplifies pagination, particularly for controller methods, while standardizing JSON output for APIs. It's meant to work both as a standalone pagination gem and as an extra layer over [Kaminari](https://github.com/kaminari/kaminari) and [will_paginate](https://github.com/mislav/will_paginate).

## Installation
Add the following line to your application's Gemfile:

```ruby
gem 'wor-paginate'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install wor-paginate
```

Then you can run `rails generate wor:paginate:install` to create the initializer for configuration details, including default formatter class, page and limit params and default page number.

## Usage
### Basic usage
The basic use case is to paginate using default values. This is achieved by including the module in a controller and calling render_paginate in the method that needs pagination.
```ruby
  class DummyModelsController < ApplicationController
    include Wor::Paginate

    def index
      render_paginated DummyModel
    end
  end
```
The first parameter to render_paginated can be multiple things:
* ActiveRecord/ActiveRecord::Relation
* Enumerables (for example, arrays and ranges)
* Pre-paginated Kaminari or will_paginate relations (original pagination will be ignored)

The response to the index will then be:
```json
{
  "page": [
    {
      "id": 1,
      "name": "1c",
      "something": 27
    },
    {
      "id": 2,
      "name": "i",
      "something": 68
    },
    // ...
    {
      "id": 25,
      "name": "2m",
      "something": 32
    }
  ],
  "count": 25,
  "total_pages": 2,
  "total_count": 28,
  "current_page": 1,
  "previous_page": null,
  "next_page": 2,
  "previous_page_url": null,
  "next_page_url": "http://api.example.com/users?page=2
}
```

Page number is passed through the `page` option of the `render_paginated` method. If none is supplied, `params[:page]` will be used, (or the default parameter configured in the initializer).
By default, if the page parameter is not present we will use 1 as the page (or the default `page` parameter configured in the initializer).
The amount of items is passed through the `limit` option of the `render_paginated` method. If none is supplied, `params[:limit]` will be used (or the default parameter configured in the initializer). Default is 25.
The default serializer and formatter will be used.

### Customizing output
#### Custom serializers
A custom serializer for each object can be passed using the `each_serializer` option:
```ruby
render_paginated DummyModel, each_serializer: CustomDummyModelSerializer
```
where the serializer is just an [`ActiveModel::Serializer`](https://github.com/rails-api/active_model_serializers).

#### Custom options
##### max_limit
The max amount of items is passed through the `max_limit` option, You can set the value in the initializer or in the `render_paginated` method, (If none is supplied, take the default value configured in the initializer). Default is 50.

```ruby
  render_paginated DummyModel, max_limit: 100
```

##### current_user
Using custom options in serializer, example method `current_user`

```ruby
render_paginated DummyModel, each_serializer: CustomDummyModelSerializer, current_user: current_user
```

In serializer

```ruby
class CustomSerializer < ActiveModel::Serializer
  def method
    @instance_options[:current_user]
  end
end
```

##### total_count
You can overwrite the `total_count` pagination param by passing it as a single option to the method. This could be used if the whole collection to be paginated is complex and has the risk to broke when counting all the records.

```ruby
  render_paginated DummyModel, total_count: 50
```

##### preserve_records
> WARNING: This option only works with an ActiveRecord collection.

Preserve records option can be added to `render_paginated` to mantain current records. This allow to navigate pages like an infinite scroll without adding new records when switching pages.

- Timestamp mode (default)
```ruby
def index
  render_paginated SomeModel, preserve_records: true 
end

# You can customize the field used to preserve this records (default is 'created_at')
def index
  render_paginated SomeModel, preserve_records: { by: :timestamp, field: :custom_time_field } 
end
```

- PK mode
```ruby
def index
  render_paginated SomeModel, preserve_records: { by: :id } 
end

# You can customize the field used to preserve this records (default is 'id')
def index
  render_paginated SomeModel, preserve_records: { by: :id, field: :my_custom_id_field }
end
```


### Custom formatters
A formatter is an object that defines the output of the render_paginated method. In case the application needs a different format for a request, it can be passed to the `render_paginated` method using the `formatter` option:
```ruby
render_paginated DummyModel, formatter: CustomFormatter
```
or it can also be set as a default in the initializer.

A new formatter can be created inheriting from the default one. The `format` method should be redefined returning something that can be converted to json.

```ruby
class CustomFormatter < Wor::Paginate::Formatter
  def format
    { page: serialized_content, current: current_page }
  end
end
```

Available helper methods are:
* `current_page`: integer with the current page
* `count`: number of items in the page (post-pagination)
* `total_count`: number of total items (pre-pagination)
* `total_pages`: number of pages given the current limit (post-pagination)
* `paginated_content`: its class depends on the original content passed to render_paginated, it's the paginated but not yet serialized content.
* `serialized_content`: array with all the items after going through the serializer (either the default or a supplied one)


### Custom adapters
An adapter is an object that defines how to show the rendered content, and how to calculate several methods of the pagination, such as 'total_count', 'total_pages', 'paginated_content' among others. In case the application needs a different adapter or a custom one, it can be passed to the `render_paginated` method using the `adapter` option:
```ruby
render_paginated DummyModel, adapter: CustomAdapter
```
or it can also be set as a default in the initializer.

A new adapter can be created inheriting from the default Base Adapter. Some methods must be redefined in order to make the adapter "adaptable" to the content that will be rendered.
Below is an example of a simple posible CustomAdapter that extends from the base Adapter.

```ruby
class CustomAdapter < Wor::Paginate::Adapters::Base
  def required_methods
    %i[count]
  end

  def paginated_content
    @paginated_content ||= @content.first(5)
  end

  def total_pages
    (total_count / @limit.to_f).ceil
  end

  def total_count
    @content.count
  end

  delegate :count, to: :paginated_content
end
```
Here's a brief explanation on every overwritten method in this CustomAdapter example:
##### required_methods:
These will be the methods (as symbols) that the content to be rendered has to support. The next expression will be evaluated for every method added here: `@content.respond_to? method`. All required_methods must answer `true` to the previous expression, in order to make the adapter "adaptable" for the content. For example, if we rendered an ActiveRecord_Relation, this CustomAdapter would be adaptable because an ActiveRecord_Relation responds to the `count` method. At least one symbol has to be returned in this method, otherwise the adapter won't be able to render content. 

##### paginated_content:
This is how the content will be shown. As the content comes in the inherited instance variable `@content`, we can transform the content however we want. In the CustomAdapter example, will always be shown the first 5 records.

##### total_pages:
This could be defined as the number of pages, given the limit requested. As the other values, this can be a custom number of pages, depending on your needs. For this example, this number is just an integer calculation of the total pages, depending on the limit. Also, like `@content`, we are inheriting the `@limit` variable, which allows us to operate with it however we want.

##### total_count:
This will be the number that will tell us 'how many records is returning the request'. Again, we can customize it however we want. For this particular example this will be just the count of `@content`.

##### count method as delegate:
In the end of the CustomAdapter we are delegating the `count` method to the `paginated_content`. This is because the Base Adapter delegates that method to the inherited adapter, so owr custom adapter has to know "how to calculate" that method, that's why we are defining a `count` method in the delegation (It is always mandatory to define the `count` method in a custom adapter, whether is a method definition or a delegate).

If the content is an ActiveRecord_Relation, for example, this adapter would work, because `paginated_content` would become an ActiveRecord_Relation, which actually knows "how to calculate" the count method. This works as a delegate, because ActiveRecord_Relation has an internal `count` definition, but we would have to provide the needed method definition if it is a custom method, or we want a custom behaviour of a known method.

##### other available methods to overwrite:
`Wor::Paginate::Adapters::Base` also has implementations for `next_page` and `previous_page` methods (which calculate the number of the next and previous pages, respectively). If you want, you can also overwrite those methods, to calculate custom 'next' and 'previous' page numbers.

To understand better the implementation of the Base Adapter and how you could overwrite methods in order to make a functional Custom Adapter, take a look at its definition in: https://github.com/Wolox/wor-paginate/blob/master/lib/wor/paginate/adapters/base.rb.
Keep in mind that an instance of your Custom Adapter must answer `true` to the `adapt?` method inherited from the Base Adapter, in order to make it "adaptable" to the content.

#### Adapters Operations
There are also helper methods available to dynamically operate the gem's adapters, so you can configurate them, whether in the initializer or in an internal part of your application. Once you include the gem, you'll be provided with the following methods, inside the Config module:
* `Config.add_adapter(adapter)`: Add an specific adapter to the array of the gem's adapters. The 'adapter' variable must be a Class reference to an Adapter Class (that class has to have a similar structure as the CustomAdapter example above).
* `Config.remove_adapter(adapter)`: Remove an specific adapter from the array of the gem's adapters.
* `Config.clear_adapters`: This method empties the array of the gem's adapters.
* `Config.adapters`: Returns all the current internal adapters inside the gem.
* `Config.reset_adapters!`: This helper resets the gem's adapters to its default array of adapters. You can see how the array of default adapters looks like at the beggining of the `Wor::Paginate::Config` module: https://github.com/Wolox/wor-paginate/blob/master/lib/wor/paginate/config.rb.

When the gem paginates, it tries to adapt the content to the first adapter that is "adaptable" for the content (unless a custom adapter has been passed to render_paginated or a default_adapter has been defined in the initializer). So beware of which adapters (and in which order) are you leaving in the `Config.adapters` array, because depending on those, the gem will try to adapt the content.


### Working with Kaminari or will_paginate
If either Kaminari or will_paginate are required in the project, Wor::Paginate will use them for pagination with no code or configuration change.

### Test helpers
You can use the `be_paginated` matcher to test your endpoints. It also accepts the `with` chain method to receive a formatter.

You only need to add this in your rails_helper.rb

```ruby
# spec/rails_helper.rb
require 'wor/paginate/rspec'
```

And in your spec do
```ruby
# spec/controllers/your_controller.rb
describe YourController do
  let(:response_body) do
    ActiveSupport::JSON.decode(response.body) if response.present? && response.body.present?
  end

  describe '#index' do
    subject(:http_request) { get :index }

    it { expect(response_body).to be_paginated }
  end

  describe '#index_with_custom_formatter' do
    subject(:http_request) { get :index_custom_formatter }

    it 'checks that the response keys matches with the custom formatter' do
      expect(response_body).to be_paginated.with(CustomFormatter)
    end
  end
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Run rubocop lint (`bundle exec rubocop -R --format simple`)
5. Run rspec tests (`bundle exec rspec`)
6. Push your branch (`git push origin my-new-feature`)
7. Create a new Pull Request to `master` branch

## Releases
📢 [See what's changed in a recent version](https://github.com/Wolox/wor-paginate/releases)

## About ##

The current maintainers of this gem are :
* [Martín Mallea](https://github.com/mnmallea)

This project was developed by:
* [Hugo Farji](https://github.com/hdf1986)
* [Ignacio Coluccio](https://github.com/icoluccio)
* [Alan Halatian](https://github.com/alanhala)

At [Wolox](http://www.wolox.com.ar)

[![Wolox](https://raw.githubusercontent.com/Wolox/press-kit/master/logos/logo_banner.png)](http://www.wolox.com.ar)

## License

**wor-paginate** is available under the MIT [license](https://raw.githubusercontent.com/Wolox/wor-paginate/master/LICENSE.md).

    Copyright (c) 2017 Wolox

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"), to deal
    in the Software without restriction, including without limitation the rights
    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
    copies of the Software, and to permit persons to whom the Software is
    furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included in
    all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
    THE SOFTWARE.
