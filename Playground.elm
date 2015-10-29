import Tab.ReviewTab exposing (init, update, view)
import Component.Show as Show
import StartApp.Simple exposing (start)
import Svg exposing (Svg)
import Time
import Component.Review as Review
import Component.ReviewList as ReviewList

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

     firefly = (Show.init "Firefly" fireflyBanner fireflyPoster "#291E1A"
      "white" "2002" "TV-14" "44m"
      "Five hundred years in the future, a renegade crew aboard a small
      spacecraft tries to survive as they travel the unknown parts of the galaxy
      and evade warring factions as well as authority agents out to get them.")
     buffy = (Show.init "Buffy" buffyBanner buffyPoster "#E27477"
      "black" "1997" "TV-14" "44m"
      "A young girl, destined to slay vampires, demons and other infernal
      creatures, deals with her life fighting evil, with the help of her
      friends.")
     dollhouse = (Show.init "Dollhouse" dollhouseBanner dollhousePoster "#ACA18E"
      "black" "2009" "TV-14" "44m"
      "A futuristic laboratory assigns different tasks to its various residents,
      who then have their memories erased upon the completion of their
      assignments.")

     user = { handle = "gziegan" , firstName = "Greg", lastName = "Ziegan",
              email = "greg.ziegan@gmail.com", phone = "012-345-6789" }

     defaultTime = Time.second

     fireflyReview = Review.init firefly 5 defaultTime user
     buffyReview = Review.init buffy 4 defaultTime user
     dollhouseReview = Review.init dollhouse 3 defaultTime user

     reviewList = ReviewList.initWithReviews [fireflyReview, buffyReview, dollhouseReview]
  in
    start
      {
        model = init user reviewList,
        update = update,
        view = view
      }
