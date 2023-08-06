defmodule LibraryFees do
  def datetime_from_string(string) do
    NaiveDateTime.from_iso8601(string)
    |> elem(1)
  end

  def before_noon?(datetime) do
    datetime.hour < 12
  end

  def return_date(checkout_datetime) do
    checkout_datetime
    |> NaiveDateTime.add(borrow_days_count(checkout_datetime), :day)
    |> NaiveDateTime.to_date()
  end

  defp borrow_days_count(checkout_datetime) do
    if before_noon?(checkout_datetime), do: 28, else:  29
  end

  def days_late(planned_return_date, actual_return_datetime) do
    max(Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date), 0)
  end

  def monday?(datetime) do
    datetime
    |> NaiveDateTime.to_date()
    |> Date.day_of_week() == 1
  end

  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)
    actual_rate = if monday?(return_datetime), do: rate * 0.5, else: rate
    checkout
    |> datetime_from_string()
    |> return_date()
    |> days_late(return_datetime)
    |> Kernel.*(actual_rate)
    |> trunc()
  end
end
