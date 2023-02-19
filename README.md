# ClusterMap

1. Break up the large array into smaller chunks that can be processed by each node.
2. Spawn an Elixir process on each machine that will be processing a chunk of the array. Each process should have a unique name so that they can communicate with each other.
3. Send the chunks of the array to each process for processing.
4. Have each process sum its chunk of the array and send the result back to the parent process.
5. The parent process can then sum the results from each child process to get the total sum of the array.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `cluster_map` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:cluster_map, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/cluster_map>.

