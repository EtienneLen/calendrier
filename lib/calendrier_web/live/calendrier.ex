defmodule CalendrierWeb.Calend do
  use Phoenix.LiveView, layout: {CalendrierWeb.LayoutView, "live.html"}

  def mount(_params = %{"year" => year, "month" => month, "day" => day}, _session, socket) do
    start = Date.new!(String.to_integer(year),String.to_integer(month),String.to_integer(day))
    begin = start |> Date.beginning_of_month()
    end_month = begin |> Date.end_of_month()
    calendar = Date.range(Date.beginning_of_week(begin), Date.end_of_week(end_month))

    socket = assign(socket, calendar_to_display: Enum.chunk_every(calendar,7))
    {:ok, socket}
  end
  def render(assigns) do
    ~H"""
      <hr>
      <table>
      <thead>
        <tr>
          <th>Mon</th>
          <th>Tue</th>
          <th>Wed</th>
          <th>Thu</th>
          <th>Fri</th>
          <th>Sat</th>
          <th>Sun</th>
        </tr>
      </thead>
      <%= for row <- @calendar_to_display do  %>
        <tr>
        <%= for cell <- row do %>
          <td><%= cell %></td>
        <% end %>
        </tr>
      <% end %>

      </table>
    """
  end

end
