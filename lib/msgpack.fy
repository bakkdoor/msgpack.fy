require("rubygems")
require("msgpack")
require("msgpack/rpc")

MessagePack metaclass tap: @{
  alias_method: 'pack: for_ruby: 'pack
  alias_method: 'unpack: for_ruby: 'unpack
}

class MessagePack RPC Server {
  forwards_unary_ruby_methods
  alias_method: 'listen:port:handler: for_ruby: 'listen
}

class MessagePack RPC Client {
  class ClientProxy : BasicObject {
    def initialize: @client
    def send_future: m with_params: p {
      @client call_async_apply(m, p)
    }
    def send_async: m with_params: p {
      @client notify_apply(m, p)
    }
    def unknown_message: m with_params: p {
      @client call_apply(m, p)
    }
  }

  forwards_unary_ruby_methods
  metaclass alias_method: 'orig_new:port: for_ruby: 'new

  def self new: host port: port {
    client = new(host, port)
    ClientProxy new: client
  }

  def call: msg with_params: params {
    call(msg, *params)
  }
}

class MessagePack RPC Future {
  forwards_unary_ruby_methods
  alias_method: 'value for_ruby: 'get

  def when_done: block {
    attach_callback(&block)
  }

  def with_value: block {
    when_done: |f| {
      block call: [f value]
    }
  }
}