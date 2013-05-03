# Konamio

Default Usage:
```ruby
> Konamio::Sequence::Requisition.new
Enter konami code (or hit escape)
Good job, you.

=> #<Konamio::Sequence::Requisition:0x8821de4
 @confirmation="Good job, you.",
 @prompt="Enter konami code (or hit escape)",
 @sequence="\e[A\e[A\e[B\e[B\e[D\e[C\e[D\e[CBA">
```

You can configure it to listen for any sequence you want:
```ruby
> Konamio::Sequence::Requisition.new(sequence: "a".upto("z").to_a.reverse, prompt: "Say the alphabet backwards", confirmation: "Okay, you can go")
Say the alphabet backwards
Okay, you can go
=> #<Konamio::Sequence::Requisition:0x8699bac
 @confirmation="Okay, you can go",
 @prompt="Say the alphabet backwards",
 @sequence=["z","y","x",...,"a"]>
```

Just something fun for me folks to play with...
