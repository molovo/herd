# Herd

A simple module to help with running multi-threaded processes in [Crystal](https://crystal-lang.org)

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  herd:
    github: molovo/herd
```

## Usage

```crystal
require "herd"
require "http/server"

# Create a new cluster with 4 threads
cluster = Cluster.new 4

# Specify the process to run
cluster.execute do
  server = HTTP::Server.new(8080) do |context|
    context.response.print "Hello World!"
  end
  puts "Thread #{Cluster.thread} listening on http://127.0.0.1:8080"
  server.listen true
end
```

## Contributing

1. Fork it ( https://github.com/molovo/cluster/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [molovo](https://github.com/molovo) James Dinsdale - creator, maintainer
