import Component.Show exposing (init, update, view)
import StartApp.Simple exposing (start)
import Svg exposing (Svg)

main : Signal Svg.Svg
main =
  let
     fireflyPath = "./mock/show/firefly/"
     fireflyBanner = fireflyPath ++ "firefly-banner.jpg"
     fireflyPoster = fireflyPath ++ "firefly-poster.jpg"
  in
    start
      {
        model = init "Firefly" fireflyBanner fireflyPoster,
        update = update,
        view = view
      }