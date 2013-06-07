## Konamio [![Gem Version](https://badge.fury.io/rb/konamio.png)](http://badge.fury.io/rb/konamio)  [![Build Status](https://travis-ci.org/rthbound/konamio.png?branch=master)](https://travis-ci.org/rthbound/konamio) [![Coverage Status](https://coveralls.io/repos/rthbound/konamio/badge.png)](https://coveralls.io/r/rthbound/konamio)


![Konami Code](http://images.nintendolife.com/news/2012/01/the_origins_of_the_konami_code_revealed/attachment/0/small.jpg)

    gem install konamio

and

    require "konamio"


Default Usage:
```
> Konamio::Sequence::Requisition.new.execute!
Enter konami code (or hit escape)
Good job, you.
=> #<PayDirt::Result:0x937ddb4
  @data={:data=>{:confirmation=>"Good job, you."}},
  @success=true>
```

You can configure it to listen for any sequence you want:
```
> Konamio::Sequence::Requisition.new({
    sequence:     "a".upto("z").to_a.reverse,
    prompt:       "Say the alphabet backwards",
    confirmation: "Okay, you can go"
  }).execute!
Say the alphabet backwards
Okay, you can go
=> #<PayDirt::Result:0x9265788
  @data={:data=>{:confirmation=>"Okay, you can go"}},
  @success=true>
```

You can also specify a block of code to be executed when the sequence is received successfully.
The following code would prompt the user to enter the konami code twice:
```
Konamio::Sequence::Requisition.new.execute! { Konamio::Sequence::Requisition.new.execute! }
```
This would give you +30 lives:
```
Konamio::Sequence::Requisition.new.execute! { 30.times { puts "+1up" } }
```

## More fun

**"Password protect"** your rails console by doing the following:

1. Follow these [instructions](http://samuelmullen.com/2010/04/irb-global-local-irbrc/) to obtain a `.irbrc` file that loads your local `.irbrc`
2. Add this gem to your rails project, then create a `.irbrc` file for the project containing


```ruby
require "konamio"
Konamio::Sequence::Requisition.new.execute!
```
    
to require console users to enter the konami code, or to require some other password:

    require "konamio"
    Konamio::Sequence::Requisition.new(sequence: "foobar").execute!
