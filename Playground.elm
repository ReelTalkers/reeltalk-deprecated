import Component.Show exposing (init, update, view)
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
  in
    start
      {
        model = init "Buffy" buffyBanner buffyPoster,
        update = update,
        view = view
      }