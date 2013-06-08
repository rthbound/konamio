## Konamio

[![Gem Version](https://badge.fury.io/rb/konamio.png)](http://badge.fury.io/rb/konamio)  [![Build Status](https://travis-ci.org/rthbound/konamio.png?branch=master)](https://travis-ci.org/rthbound/konamio) [![Coverage Status](https://coveralls.io/repos/rthbound/konamio/badge.png)](https://coveralls.io/r/rthbound/konamio) [![Code Climate](https://codeclimate.com/github/rthbound/konamio.png)](https://codeclimate.com/github/rthbound/konamio)

![Konami Code](http://images.nintendolife.com/news/2012/01/the_origins_of_the_konami_code_revealed/attachment/0/small.jpg)

    gem install konamio

and

    require "konamio"


### Default Usage
```
> Konamio::Sequence::Requisition.new.execute!
Enter konami code (or hit escape)
Good job, you.
=> #<Konamio::Result:0x937ddb4
  @data={:data=>{:confirmation=>"Good job, you."}},
  @success=true>
```

### Configuration

#### Sequences

You can configure it to listen for any ascii based sequence you want
using the `:sequence` option. This can be specified using a string
(`"foobar"`) or an array of recognized symbols and one-character strings
(escaped charactersare okay, e.g. `[:up, "1", "2", "3", "\t"]`):

```
> Konamio::Sequence::Requisition.new({
    sequence:     "a".upto("z").to_a.reverse,
    prompt:       "Say the alphabet backwards",
    confirmation: "Okay, you can go"
  }).execute!
Say the alphabet backwards
Okay, you can go
=> #<Konamio::Result:0x9265788
  @data={:data=>{:confirmation=>"Okay, you can go"}},
  @success=true>
```

#### Output

There are three dialogs that Konamio might send to stdout.

1. `:prompt` is the dialog displayed initially, and each time the user fails to supply the proper sequence.
2. `:confirmation` is displayed when the required sequence is entered properly.
3. `:cancellation` is displayed when user terminates by pressing the escape key.

You can customize any of these dialogs, or disable them individually by passing a falsey value.

#### Success!

It would be boring if all Konamio did was return a result object. That's why
`Konamio::Sequence::Requisition#execute!` **takes a block**, and will execute
that block when the sequence has been successfully entered. You're limited only
by your imagination and the context of your application. Konamio will supply
the value of the sequence to the block.

The following code would prompt the user to enter the konami code twice:
```ruby
Konamio::Sequence::Requisition.new.execute! { Konamio::Sequence::Requisition.new.execute! }
```
This would give you +30 lives:
```ruby
Konamio::Sequence::Requisition.new.execute! { 30.times { puts "+1up" } }
```

## More fun

**"Password protect"** your rails console by doing the following:

1. Follow these [instructions](http://samuelmullen.com/2010/04/irb-global-local-irbrc/) to obtain a `.irbrc` file that loads your local `.irbrc`
2. Add this gem to your rails project, then create a `.irbrc` file for the project containing


```ruby
require "konamio"
Konamio::Sequence::Requisition.new(prompt: false, confirmation: false, cancellation: false).execute!
```

to require console users to enter the konami code. This funny trick obviously does not provide any real protection, but it would certainly make for a nasty practical joke.
