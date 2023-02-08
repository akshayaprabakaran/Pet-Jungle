defmodule PetjungleWeb.PetJungleLive.Index do
  use PetjungleWeb, :live_view

  import Ecto.Changeset
  alias PetJungle.Plants
  alias PetJungle.PetFriendly

  @impl true
  def mount(_params, _session, socket) do
    {
      :ok,
      socket
      |> assign(:plants, list_plants())
      |> assign(:changeset, search_changeset())
    }
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"search_and_filter" => %{"search_phrase" => "", "filter_by" => ""}},
        socket
      ) do
    {:noreply, assign(socket, :plants, list_plants())}
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"search_and_filter" => %{"search_phrase" => search, "filter_by" => ""}},
        socket
      ) do
    search = %{"search_phrase" => search}

    search
    |> search_changeset()
    |> case do
      %{valid?: true, changes: %{search_phrase: search_phrase}} ->
        {:noreply, assign(socket, :plants, Plants.search_plants(search_phrase))}

      _ ->
        {:noreply, socket}
    end
  end

  @impl true
  def handle_event(
        "search_and_filter",
        %{"search_and_filter" => %{"filter_by" => filter_by}},
        socket
      ) do
    filter = map_filters(filter_by)

    {:noreply, assign(socket, :plants, Plants.list_plants(filter))}
  end

  defp map_filters("Indoor Only") do
    %{plant_type: :indoor}
  end

  defp map_filters("Outdoor Only") do
    %{plant_type: :outdoor}
  end

  defp map_filters("Cat Safe") do
    %{pet_name: "Cat"}
  end

  defp map_filters("Dog Safe") do
    %{pet_name: "Dog"}
  end

  defp map_filters("Horse Safe") do
    %{pet_name: "Horse"}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Plants")
    |> assign(:plant, nil)
  end

  defp list_plants do
    Plants.list_plants()
  end

  defp pet_friendly_list(plant_id) do
    pet_list =
      PetFriendly.list_petfriendly()
      |> Enum.map(fn {p_id, pet_name} ->
        if p_id == plant_id do
          pet_name
        end
      end)
      |> Enum.reject(&(&1 == nil))
      |> Enum.sort()

    if pet_list == [] do
      ["Toxic"]
    else
      pet_list
    end
  end

  defp search_changeset(attrs \\ %{}) do
    cast(
      {%{}, %{search_phrase: :string}},
      attrs,
      [:search_phrase]
    )
    |> validate_required([:search_phrase])
    |> update_change(:search_phrase, &String.trim/1)
    |> validate_length(:search_phrase, min: 2)
    |> validate_format(:search_phrase, ~r/[A-Za-z0-9\ ]/)
  end

  defp get_image_url(pet) do
    "/assets/#{pet}.png"
  end
end
