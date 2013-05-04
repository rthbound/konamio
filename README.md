## Konamio

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
