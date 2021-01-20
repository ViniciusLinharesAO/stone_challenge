defmodule StoneChallenge do
  @files_path "./lists/"
  @items_list @files_path<>"items_list.json"
  @emails_list @files_path<>"email_list.json"

  @spec main(String.t(), String.t()) :: {:error, String.t() | Poison.ParseError.t | Poison.DecodeError.t} | %{String.t() => number()}
  def main(items_file_name \\ @items_list, emails_file_name \\ @emails_list) do
    with {:ok, %{"items" => list_of_items}} <- get_content(items_file_name),
         {:ok, %{"emails" => list_of_emails}} <- get_content(emails_file_name),
         :ok <- list_of_emails |> validate_min_length(1)
    do
      n_emails = list_of_emails |> length

      list_of_items
      |> sum_items_value
      |> division(n_emails)
      |> distribute_values(n_emails)
      |> format_response(list_of_emails)
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec get_content(String.t()) :: {:error, String.t() | Poison.ParseError.t | Poison.DecodeError.t} | {:ok, map()}
  def get_content(file_path) do
    with {:ok, content} <- read_file(file_path),
         {:ok, decoded_content} <- Poison.decode(content) do
      {:ok, decoded_content}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  @spec read_file(String.t() | Path.t) :: {:error, String.t()} | {:ok, binary}
  defp read_file(file_path) do
    case File.read(file_path) do
      {:ok, content} -> {:ok, content}
      {:error, reason} -> {:error, :file.format_error(reason)}
    end
  end

  @spec validate_min_length([any()], number()) :: {:error, String.t()} | :ok
  defp validate_min_length(list, min), do: if length(list) >= min, do: :ok, else: {:error, "there are no emails required for distribution"}

  @spec sum_items_value([%{String.t() => number()}]) :: number()
  def sum_items_value(list_of_items) do
    list_of_items
    |> Enum.reduce(0, fn %{"price" => price, "amount" => amount}, acc ->
      acc + price * amount
    end)
  end

  @spec division(number(), number()) :: {:error, String.t()} | {number(), number()}
  defp division(_value_1, value_2) when value_2 == 0, do: {:error, "invalid division by zero"}
  defp division(value_1, value_2), do: {div(value_1, value_2), rem(value_1, value_2)}


  @spec distribute_values({number(), number()}, number()) :: [number()]
  defp distribute_values({div_result, div_rem}, n_emails) do
    base_list = List.duplicate(div_result, (n_emails - div_rem))
    if div_rem != 0 do
      base_list ++ List.duplicate(div_result + 1, div_rem)
    else
      base_list
    end
  end

  @spec format_response([number()], [String.t()]) :: map()
  defp format_response(list_of_values, list_of_emails) do
    list_of_emails
    |> Enum.zip(list_of_values)
    |> Enum.into(%{})
  end
end
