# Stone Challenge Answer

This project is my answer to the [stone challenge](https://gist.github.com/programa-elixir/1bd50a6d97909f2daa5809c7bb5b9a8a).

Created with Erlang/OTP 23 and Elixir 1.11.2

### Installation

Clone the rep and install the dependencies.

```sh
$ git clone https://github.com/ViniciusLinharesAO/stone_challenge.git
$ cd stone_challenge
$ mix deps.get
```
### Running
```sh
$ mix run_project
```

You can change the inputs modifying "email_list.json" and "item_list.json" located at "./lists".

### Email list sample:
```json
{
  "emails": [
    "email1@email.com",
    "email2@email.com",
    ...
  ]
}
```

### Item list sample:
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

### Running tests
 Start the server and run the code
```sh
$ mix test
```

### Deps
- Poison -  https://hex.pm/packages/poison


### Notes
* Enum.zip = Corresponding elements from two enumerables into one list of tuples. ex: Enum.zip(["a", "b", "c"], [0, 1, 2]) = [{"a", 0}, {"b", 1}, {"c", 2}]
* Enum.into = Inserts the given enumerable into a collectable. ex: Enum.into([{"a", 0}, {"b", 1}, ...], %{}) = %{"a" => 0, "b" => 1, ...}
* List.duplicate = Duplicates the given element n times in a list. ex: List.duplicate(0, 3) = [0, 0, 0]

### Main line of thought
* Sabendo que o Resto de uma Divisao sempre vai ser um numero inteiro entre 0 e N-1, sendo N o Dividendo, chegamos a conclusão de que uma parte dos Users (identificados por email) terão valor equivalente ao Resultado da Divisão e outra parte valor igual a (Resultado da Divisão + 1). Então, (n_users - Resto da Divisão) Users terão o valor de Resultado da Divisão e Resto da Divisão Users teram o valor de (Resultado da Divisão + 1).

License
----

MIT
