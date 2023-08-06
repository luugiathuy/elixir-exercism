defmodule NameBadge do
  def print(id, name, department) do
    id_string = if id, do: "[#{id}] - ", else: ""
    department_str = if department, do: String.upcase(department), else: "OWNER"
    "#{id_string}#{name} - #{department_str}"
  end
end
