import Component.Review exposing (init, update, view)
import StartApp.Simple exposing (start)
import Time exposing (second)

main =
  start
    { model = init { title = "Firefly" } 5 Time.second
    , update = update
    , view = view
    }
