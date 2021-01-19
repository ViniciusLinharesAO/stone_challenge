# StoneChallenge

**TODO: Add description**

// Enum.zip intercala duas listas com base no index, ex: (["a", "b", "c"], [0, 1, 2]) retorna [{"a", 0}, {"b", 1}, {"c", 2}]
// Enum.into transforma [{"a", 0}, {"b", 1}, ...] em %{"a" => 0, "b" => 1, ...}
// List.duplicate cria uma lista repetindo algo, ex: (0, 3) retorna [0, 0, 0]

# Sabendo que o Resto de uma Divisao sempre vai ser um numero inteiro entre 0 e N-1, sendo N
# o Dividendo, chegamos a conclusão de que uma parte dos Users (identificados por email) terá
# valor igual ao Resultado da divisão e outra parte (Resultado + 1) da Divisão.
# Então, (n_emails - Resto) Users terão o valor de Resultado e Resto emails teram o valor de (Resultado + 1)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `stone_challenge` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:stone_challenge, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/stone_challenge](https://hexdocs.pm/stone_challenge).
