# MuseekBindings

This gem provides bindings for [museek](http://museek-plus.org/) daemon.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'museek_daemon'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install museek_daemon

## Usage example

* Login

```ruby
require 'museek_bindings'
require 'socket'

sock = UNIXSocket.new '/tmp/museekd.sock'

loop do
  length = sock.read(4).unpack('L').first
  code = sock.read(4).unpack('L').first
  message = sock.read(length - 4)

  if MuseekBindings::MessageMap[code] == MuseekBindings::Message::Challenge
    # Reveived Challenge, let's parse it!
    message = MuseekBindings::Message::Challenge.new(data: message)

    # Interface password, use musetup to find out.
    pass = 'INTERACE_PASSWORD'
    # Form the login message
    login = MuseekBindings::Message::Login.new(challenge: message.challenge, password: pass)

    sock.write(login.to_binary) # Voila, we are in!
  end
end
```

* Send a private message

```ruby
message = MuseekBindings::Message::PrivateMessage(user: 'Recipient', message: 'Dear Mr. Recipient! How are you today?')
sock.write(message.to_binary)
```

* Perform a search

```ruby
# Assuming that sock is already opened
#
# You need to create a listener-loop
# Don't forget to kill the forked process
pid = fork do
  loop do
    length = sock.read(4).unpack('L').first
    code = sock.read(4).unpack('L').first
    message = sock.read(length - 4)

    if MuseekBindings::MessageMap[code] == MuseekBindings::Message::SearchReply
      reply = MuseekBindings::Message::SearchReply.new(data: message)
      puts "Username: #{reply.user}"
      reply.results.each do |res|
        puts "path: #{res.path}"
      end
    end
  end
end

# Let's search for Buffalo Tom's music.
search = MuseekBindings::Message::Search.new(query: 'Buffalo Tom')
sock.write(search.to_binary)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/akhramov/museek_bindings.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
