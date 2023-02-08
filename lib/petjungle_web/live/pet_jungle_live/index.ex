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
        "search_plants",
        %{"search_plants" => %{"search_phrase" => search_phrase}},
        socket
      )
      when search_phrase == "" do
    {:noreply, assign(socket, :plants, list_plants())}
  end

  @impl true
  def handle_event("search_plants", %{"search_plants" => search}, socket) do
    search
    |> search_changeset()
    |> case do
      %{valid?: true, changes: %{search_phrase: search_phrase}} ->
        {:noreply, assign(socket, :plants, Plants.search_plants(search_phrase))}

      _ ->
        {:noreply, socket}
    end
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

  @types %{search_phrase: :string}

  defp search_changeset(attrs \\ %{}) do
    cast(
      {%{}, @types},
      attrs,
      [:search_phrase]
    )
    |> validate_required([:search_phrase])
    |> update_change(:search_phrase, &String.trim/1)
    |> validate_length(:search_phrase, min: 2)
    |> validate_format(:search_phrase, ~r/[A-Za-z0-9\ ]/)
  end

  def get_image_url(pet) do
   "/priv/static/assets/#{pet}.png"
  end
end
