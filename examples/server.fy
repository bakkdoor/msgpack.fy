require: "msgpack.fy"

class MyHandler {
  def add: a to: b {
    return a + b
  }

  def print_this: str {
    "Got: #{str inspect}" println
  }
}

server = MessagePack RPC Server new
server listen: "0.0.0.0" port: 9090 handler: $ MyHandler new
server run
