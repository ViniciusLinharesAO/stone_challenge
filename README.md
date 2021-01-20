# Stone Challenge Answer

This project is my answer to the [stone challenge](https://gist.github.com/programa-elixir/1bd50a6d97909f2daa5809c7bb5b9a8a).

Created with Erlang/OTP 23 and Elixir 1.11.2
### Installation

Clone the rep and install the dependencies.

```sh
$ cd stone_challenge
$ mix deps.get
```
### Running
 Start the server and run the code
```sh
$ iex -S mix run
iex(1)> StoneChallenge.main
```

You can change the inputs modifying "email_list.json" and "item_list.json" located at "./lists".

### email_list sample:
```json
{
  "emails": [
    "email1@email.com",
    "email2@email.com",
    ...
  ]
}
```

### item_list sample:
```json
{
  "items": [
    {
      "name": "item1",
      "price": 9,
      "amount": 1
    },
    {
      "name": "item2",
      "price": 9,
      "amount": 2
    },
    ...
  ]
}
```

### Deps
- Poison -  https://hex.pm/packages/poison


### Anotações
* Enum.zip intercala duas listas com base no index, ex: (["a", "b", "c"], [0, 1, 2]) retorna [{"a", 0}, {"b", 1}, {"c", 2}]
* Enum.into transforma [{"a", 0}, {"b", 1}, ...] em %{"a" => 0, "b" => 1, ...}
* List.duplicate cria uma lista repetindo algo, ex: (0, 3) retorna [0, 0, 0]
* Sabendo que o Resto de uma Divisao sempre vai ser um numero inteiro entre 0 e N-1, sendo N o Dividendo, chegamos a conclusão de que uma parte dos Users (identificados por email) terá valor igual ao Resultado da divisão e outra parte valor igual a (Resultado + 1) da Divisão.
* Então, (n_emails - Resto) Users terão o valor de Resultado e Resto emails teram o valor de (Resultado + 1)

### Todos

 - Tests
 - Validations

License
----

MIT
