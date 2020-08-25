# Tobaccos Club
![Build](https://github.com/edgarlatorre/tobaccos_club/workflows/Build/badge.svg)

To start the application:

  * Start container with postgres database `make start_db`
  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Database
The database runs inside a docker container, below you can find some commands to use it:

  * Start postgres container: `make start_db`
  * Stop postgres container: `make stop_db`
  * Access psql console: `make db_console`
