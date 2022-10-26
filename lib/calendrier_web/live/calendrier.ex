defmodule CalendrierWeb.Calend do
  use Phoenix.LiveView, layout: {CalendrierWeb.LayoutView, "live.html"}

  def mount(_params = %{"year" => year, "month" => month, "day" => day}, _session, socket) do
    start = Date.new!(String.to_integer(year),String.to_integer(month),String.to_integer(day))
    begin = start |> Date.beginning_of_month()
    end_month = begin |> Date.end_of_month()
    calendar = Date.range(Date.beginning_of_week(begin), Date.end_of_week(end_month))

    socket = assign(socket, calendar_to_display: Enum.chunk_every(calendar,7), selected_date: "Aucune date sélectionnée")
    {:ok, socket}
  end


  def handle_event("select_cell", value, socket) do
    %{
      "selected-date" => selected_date
    } = value
    IO.inspect(selected_date)
    socket = assign(socket, selected_date: selected_date )
    {:noreply, socket}
  end
  def render(assigns) do
    ~H"""
      <div class="m-16  rounded-lg">
        <h2><%= @selected_date %></h2>
        <table class="shadow text-sm text-center text-gray-500 dark:text-gray-400">
        <thead class="text-xs text-gray-700 uppercase bg-orange-100 dark:bg-gray-700 dark:text-gray-400">
          <tr>
            <th scope="col" class="py-3 px-6">Mon</th>
            <th scope="col" class="py-3 px-6">Tue</th>
            <th scope="col" class="py-3 px-6">Wed</th>
            <th scope="col" class="py-3 px-6">Thu</th>
            <th scope="col" class="py-3 px-6">Fri</th>
            <th scope="col" class="py-3 px-6">Sat</th>
            <th scope="col" class="py-3 px-6">Sun</th>
          </tr>
        </thead>
        <%= for row <- @calendar_to_display do  %>
          <tr class="bg-white border-b dark:bg-gray-800 dark:border-gray-700">
          <%= for cell <- row do %>
            <%= if Date.to_string(cell) == @selected_date do %>
              <td phx-click="select_cell" phx-value-selected-date={cell} scope="row" class=" hover:bg-orange-200 hover:text-blue-800 bg-orange-200 py-4 px-6 border-l border-r font-medium text-gray-900 whitespace-nowrap dark:text-white"><%= Calendar.strftime(cell, "%d") %></td>
            <% else %>
              <td phx-click="select_cell" phx-value-selected-date={cell} scope="row" class=" hover:bg-orange-200 hover:text-blue-800 py-4 px-6 border-l border-r font-medium text-gray-900 whitespace-nowrap dark:text-white"><%= Calendar.strftime(cell, "%d") %></td>
            <% end %>
          <% end %>
          </tr>
        <% end %>

        </table>
      </div>
    """
  end

end
