# Simple Fancy wrapper for MessagePack serialization and rpc library.

## Sample server:

```fancy
require: "msgpack.fy"

class AddServer {
  def add: a to: b {
    a + b
  }
}

MessagePack RPC Server new tap: @{
  listen: "0.0.0.0" port: 1234 handler: $ AddServer new
  run
}
```

## Sample client:

```fancy
client = MessagePack RPC Client new: "127.0.0.1" port: 1234
# synchronous:
sum = client add: 1 to: 2       # => 3
# async (future send):
future = client @ add: 1 to: 2
future value                    # => 3
# pure async (no return value):
client @@ add: 1 to: 2          # => nil (not useful if you want a return value like in this example)
```

## Copyright

(C) 2012 Christopher Bertels chris@fancy-lang.org

Released under the same license as the Ruby library: Apache License, Version 2.0

### For more information see:
  - http://msgpack.org
  - https://github.com/msgpack/msgpack-ruby