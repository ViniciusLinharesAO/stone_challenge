defmodule StoneChallengeTest do
  use ExUnit.Case
  doctest StoneChallenge

  @files_path "./test/support_lists/"

  # empty lists paths
  @empty_items_lists_path @files_path<>"empty_items_lists.json"
  @empty_email_lists_path @files_path<>"empty_email_lists.json"

  # lists with many things paths
  @many_items_lists_path @files_path<>"many_items_lists.json"
  @many_email_lists_path @files_path<>"many_email_lists.json"

  # lists with one thing paths
  @one_items_lists_path @files_path<>"one_items_lists.json"
  @one_email_lists_path @files_path<>"one_email_lists.json"

  setup_all do
    assert {:ok, %{"items" => empty_items_lists}} = StoneChallenge.get_content(@empty_items_lists_path)
    assert [] = empty_items_lists

    assert {:ok, %{"emails" => [] = empty_items_lists}} = StoneChallenge.get_content(@empty_email_lists_path)

    assert {:ok,
      %{"items" => [%{"amount" => 1, "name" => "item1", "price" => 202}, %{"amount" => 2, "name" => "item2", "price" => 303}] = many_items_lists}
    } = StoneChallenge.get_content(@many_items_lists_path)

    assert {:ok,
      %{"emails" => ["email1@email.com", "email2@email.com", "email3@email.com"]}
    } = StoneChallenge.get_content(@many_email_lists_path)

    assert {:ok,
      %{"items" => [%{"amount" => 2, "name" => "item1", "price" => 101}] = one_items_lists}
    } = StoneChallenge.get_content(@one_items_lists_path)

    assert {:ok, %{"emails" => ["email1@email.com"]}} = StoneChallenge.get_content(@one_email_lists_path)

    {:ok, %{empty_items_lists: empty_items_lists, many_items_lists: many_items_lists, one_items_lists: one_items_lists}}
  end

  test "sum_items_value", %{empty_items_lists: empty_items_lists, many_items_lists: many_items_lists, one_items_lists: one_items_lists} do
    assert 0 = StoneChallenge.sum_items_value(empty_items_lists)
    assert 808 = StoneChallenge.sum_items_value(many_items_lists)
    assert 202 = StoneChallenge.sum_items_value(one_items_lists)
  end

  test "main receives invalid paths" do
    assert {:error, _reason} = StoneChallenge.main("", "")
    assert {:error, _reason} = StoneChallenge.main("a", "")
    assert {:error, _reason} = StoneChallenge.main("", "a")
    assert {:error, _reason} = StoneChallenge.main("a", "a")
  end

  test "main receives a empty email list" do
    assert {:error, _reason} = StoneChallenge.main(@empty_items_lists_path, @empty_email_lists_path)
    assert {:error, _reason} = StoneChallenge.main(@many_items_lists_path, @empty_email_lists_path)
    assert {:error, _reason} = StoneChallenge.main(@one_items_lists_path, @empty_email_lists_path)
  end

  test "main receives a empty item list" do
    assert %{"email1@email.com" => 0, "email2@email.com" => 0, "email3@email.com" => 0} =
      StoneChallenge.main(@empty_items_lists_path, @many_email_lists_path)

    assert %{"email1@email.com" => 0} = StoneChallenge.main(@empty_items_lists_path, @one_email_lists_path)
  end

  test "main receives a list with many item" do
    assert %{"email1@email.com" => 269, "email2@email.com" => 269, "email3@email.com" => 270} =
      StoneChallenge.main(@many_items_lists_path, @many_email_lists_path)

    assert %{"email1@email.com" => 808} = StoneChallenge.main(@many_items_lists_path, @one_email_lists_path)
  end

  test "main receives a one item list" do
    assert %{"email1@email.com" => 67, "email2@email.com" => 67, "email3@email.com" => 68} =
      StoneChallenge.main(@one_items_lists_path, @many_email_lists_path)

    assert %{"email1@email.com" => 202} = StoneChallenge.main(@one_items_lists_path, @one_email_lists_path)
  end

end
