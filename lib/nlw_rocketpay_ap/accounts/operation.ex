defmodule NlwRocketpayAp.Accounts.Operation do
  alias Ecto.Multi
  alias NlwRocketpayAp.Account

  def call(%{"id" => id, "value" => value}, operation) do

    operation_name = account_operation_name(operation)
    Multi.new()
    |> Multi.run(operation_name, fn repo, _changes -> get_account(repo, id) end)
    |> Multi.run(operation, fn repo, changes ->
        account = Map.get(changes, operation_name)
        update_balance(repo, account, value, operation)
      end)
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found!"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, value, operation) do
    IO.inspect(account.balance)
    account
    |> operation(value, operation)
    |> IO.inspect()
    |> update_account(repo, account)
  end

  defp operation(%Account{balance: balance}, value, operation) do
    value
    |> Decimal.cast()
    |> handle_cast(balance, operation)
  end

  defp handle_cast({:ok, value}, balance, :deposit), do: Decimal.add(value, balance)
  defp handle_cast({:ok, value}, balance, :withdraw), do: Decimal.sub(balance, value)
  defp handle_cast(:error, _balance, _operation), do: {:error, "Invalid deposit value!"}

  defp update_account({:error, _reason} = error, _repo, _account), do: error
  defp update_account(value, repo, account) do
    params = %{balance: value}

    params
    |> Account.changeset(account)
    |> repo.update()
    |> IO.inspect()
  end

  defp account_operation_name(operation) do
    "account_#{Atom.to_string(operation)}" |> String.to_atom()
  end
end
