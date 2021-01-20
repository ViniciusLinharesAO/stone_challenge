defmodule StoneChallengeTest do
  use ExUnit.Case
  doctest StoneChallenge

  @files_path "./test/support_lists/"

  # empty lists
  @empty_items_lists_path @files_path<>"empty_items_lists.json"
  @empty_email_lists_path @files_path<>"empty_email_lists.json"

  # lists with many things
  @many_items_lists_path @files_path<>"many_items_lists.json"
  @many_email_lists_path @files_path<>"many_email_lists.json"

  # lists with one thing
  @one_items_lists_path @files_path<>"one_items_lists.json"
  @one_email_lists_path @files_path<>"one_email_lists.json"

  test "validate consistency of test files" do
    assert {:ok, %{"items" => empty_items_lists}} = StoneChallenge.get_content(@empty_items_lists_path)
    assert [] = empty_items_lists
    assert {:ok, %{"emails" => empty_email_lists}} = StoneChallenge.get_content(@empty_email_lists_path)
    assert [] = empty_email_lists

    assert {:ok, %{"items" => many_items_lists}} = StoneChallenge.get_content(@many_items_lists_path)
    assert [%{"amount" => 1, "name" => "item1", "price" => 9}, %{"amount" => 2, "name" => "item2", "price" => 9}] = many_items_lists
    assert {:ok, %{"emails" => many_email_lists}} = StoneChallenge.get_content(@many_email_lists_path)
    assert ["email1@email.com", "email2@email.com", "email3@email.com", "email4@email.com", "email5@email.com"] = many_email_lists

    assert {:ok, %{"items" => one_items_lists}} = StoneChallenge.get_content(@one_items_lists_path)
    assert [%{"amount" => 1, "name" => "item1", "price" => 9}] = one_items_lists
    assert {:ok, %{"emails" => one_email_lists}} = StoneChallenge.get_content(@one_email_lists_path)
    assert ["email1@email.com"] = one_email_lists
  end

  test "sum_items_value" do
    assert 0 = StoneChallenge.sum_items_value([])

    {:ok, %{"items" => many_items_lists}} = StoneChallenge.get_content(@many_items_lists_path)
    assert 27 = StoneChallenge.sum_items_value(many_items_lists)

    {:ok, %{"items" => one_items_lists}} = StoneChallenge.get_content(@one_items_lists_path)
    assert 9 = StoneChallenge.sum_items_value(one_items_lists)
  end

  test "main receives invalid paths" do
    assert StoneChallenge.main("", "") == {:error, 'no such file or directory'}
    assert StoneChallenge.main("a", "") == {:error, 'no such file or directory'}
    assert StoneChallenge.main("", "a") == {:error, 'no such file or directory'}
    assert StoneChallenge.main("a", "a") == {:error, 'no such file or directory'}
  end

  test "main receives a empty email list" do
    assert StoneChallenge.main(@empty_items_lists_path, @empty_email_lists_path) == {:error, "there are no emails required for distribution"}
    assert StoneChallenge.main(@many_items_lists_path, @empty_email_lists_path) == {:error, "there are no emails required for distribution"}
    assert StoneChallenge.main(@one_items_lists_path, @empty_email_lists_path) == {:error, "there are no emails required for distribution"}
  end

  test "main receives a empty item list" do
    expected_result_for_many_emails = %{"email1@email.com" => 0, "email2@email.com" => 0, "email3@email.com" => 0, "email4@email.com" => 0, "email5@email.com" => 0}
    assert StoneChallenge.main(@empty_items_lists_path, @many_email_lists_path) == expected_result_for_many_emails

    expected_result_for_one_email = %{"email1@email.com" => 0}
    assert StoneChallenge.main(@empty_items_lists_path, @one_email_lists_path) == expected_result_for_one_email
  end

  test "main receives a list with many item" do
    expected_result_for_many_emails = %{"email1@email.com" => 5, "email2@email.com" => 5, "email3@email.com" => 5, "email4@email.com" => 6, "email5@email.com" => 6}
    assert StoneChallenge.main(@many_items_lists_path, @many_email_lists_path) == expected_result_for_many_emails

    expected_result_for_one_email = %{"email1@email.com" => 27}
    assert StoneChallenge.main(@many_items_lists_path, @one_email_lists_path) == expected_result_for_one_email
  end

  test "main receives a one item list" do
    expected_result_for_many_emails = %{"email1@email.com" => 1, "email2@email.com" => 2, "email3@email.com" => 2, "email4@email.com" => 2, "email5@email.com" => 2}
    assert StoneChallenge.main(@one_items_lists_path, @many_email_lists_path) == expected_result_for_many_emails

    expected_result_for_one_email = %{"email1@email.com" => 9}
    assert StoneChallenge.main(@one_items_lists_path, @one_email_lists_path) == expected_result_for_one_email
  end

end
