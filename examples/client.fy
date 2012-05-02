require: "msgpack.fy"

client = MessagePack RPC Client new: "127.0.0.1" port: 9090
val = client add: 1 to: 2
# client prints 3:
val println
# server will print "foo":
client print_this: "foo"

# sending multiple request asynchronously (using futures / future sends):
futures = (0..10) map: |i| {
  client @ add: i to: (i * i)
}

# you can also do pure async sends, without getting a return value:
10 times: |i| {
  # async sends always return nil:
  client @@ print_this: i
}

# prints: [0, 2, 6, 12, 20, 30, 42, 56, 72, 90, 110]
futures map: @{ value } . inspect println

client print_foo