# Pet Jungle

Pet Jungle is a socially informative project. People who are both pet lovers and plant lovers know how frustrating it is to manage plants in a household with pets. Many of us do not have much knowledge about the toxicity of plants to animal health. Not all plants are pet-safe. So with a motto to grow both pets and plants safely together, this web application focuses on providing the information about the plants, their toxicity level, the animals which are affected by plants(especially cat, dog and horse).

Currently, this project is an MVP of my dream application. 

Lots of features, refactoring and enhancements are coming in! Stay tuned!

## Pet Jungle's Search Feature


https://user-images.githubusercontent.com/43679591/217470095-161389d5-c9ae-403c-91d3-1f9ff48c857c.mov



## Pet Jungle's Filter Feature


https://user-images.githubusercontent.com/43679591/217470224-eff1f8c7-3568-460c-aa67-b2f0724cc0c6.mov


As of now this project,

- extracts csv dataset of plants, pets and their interdependency with respect to toxicity.
- the extracted dataset is seeded into the database.
- it searches and filters the name of the plants dynamically using fuzzy logic.
- it filters the plants by the selected plant type (indoor or outdoor)
- it filters the plants by the animal type (cat or dog or horse). This is a significant feature of the application.

The application is built from scratch using
- Elixir - Phoenix
- LiveView
- TailWind CSS
- HTML
- PostgreSQL

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`http://localhost:4000/plants`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
