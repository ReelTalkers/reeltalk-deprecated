import Component.ShowList exposing (initWithShows, update, view)
import Component.Show as Show
import StartApp.Simple exposing (start)
import Svg exposing (Svg)

main : Signal Svg.Svg
main =
  let
     showPath = "./mock/show/"
     fireflyPath = showPath ++ "firefly/"
     fireflyBanner = fireflyPath ++ "firefly-banner.jpg"
     fireflyPoster = fireflyPath ++ "firefly-poster.jpg"
     buffyPath = showPath ++ "buffy/"
     buffyBanner = buffyPath ++ "buffy-banner.jpg"
     buffyPoster = buffyPath ++ "buffy-poster.jpg"
     dollhousePath = showPath ++ "dollhouse/"
     dollhouseBanner = dollhousePath ++ "dollhouse-banner.jpg"
     dollhousePoster = dollhousePath ++ "dollhouse-poster.jpg"
     firefly = Show.init "Firefly" fireflyBanner fireflyPoster
     buffy = Show.init "Buffy" buffyBanner buffyPoster
     dollhouse = Show.init "Dollhouse" dollhouseBanner dollhousePoster
  in
    start
      {
        model = initWithShows [firefly, buffy, dollhouse],
        update = update,
        view = view
      }