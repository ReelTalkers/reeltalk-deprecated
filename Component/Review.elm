module Component.Review (Model, init, Action, update,
                         view, Context) where

import Component.Show as Show
import Component.User as User
import Time exposing (Time, every, second)
import Date exposing (year, hour, minute, second, fromTime)
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
  {
    show : Show.Model,
    score : Score,
    createdAt : Time,
    user : User.Model
  }

type alias Score = Int


init : Show.Model -> Score -> Time -> User.Model -> Model
init show score createdAt user =
  {
    show = show,
    score = score,
    createdAt = createdAt,
    user = user
  }


-- UPDATE

type ID = Int

type Action = UpdateScore Score
  | NoOp Show.Action

update : Action -> Model -> Model
update action model =
  case action of
    UpdateScore newScore ->
      { model |
          score <- newScore
      }
    NoOp showAction ->
      model

-- VIEW

view: Signal.Address Action -> Model -> Html
view address model =
  let showPoster = Show.viewAsBanner (Signal.forwardTo address NoOp) model.show
      show = model.show
  in
    div [reviewContainer model.show]
      [
        div [reviewTextStyle]
          [
            h2 [textStyle show] [text show.title],
            h3 [textStyle show] [text ("Stars: " ++ (toString model.score))],
            button [ onClick address (UpdateScore 1) ] [ text "1" ],
            button [ onClick address (UpdateScore 2) ] [ text "2" ],
            button [ onClick address (UpdateScore 3) ] [ text "3" ],
            button [ onClick address (UpdateScore 4) ] [ text "4" ],
            button [ onClick address (UpdateScore 5) ] [ text "5" ],
            span [textStyle show] [text ("  " ++ show.year ++ " " ++ show.mpaarating ++ " " ++ show.runtime)],
            br [] [],
            span [textStyle show] [text (show.description)]
          ],
        img [src show.banner, reviewBannerStyle] []
      ]



currentTime : Time -> String
currentTime t =
  let date' = fromTime t
      hour' = toString (Date.hour date')
      minute' = toString (Date.minute date')
      second' = toString (Date.second date')
      year' = toString (year date')
      now = hour' ++ ":" ++ minute' ++ ":" ++ second'
  in
    now

type alias Context =
  {
    actions : Signal.Address Action,
    remove : Signal.Address ()
  }

reviewContainer : Show.Model -> Attribute
reviewContainer show =
  style
    [ ("background-color", show.color),
      ("display", "flex"),
      ("max-height", "15em"),
      ("flex-direction", "row")
    ]

reviewTextStyle : Attribute
reviewTextStyle =
  style
    [ ("flex", "2 1 auto")
    ]

textStyle : Show.Model -> Attribute
textStyle show =
  style
    [ ("color", show.textColor)
    ]

reviewBannerStyle : Attribute
reviewBannerStyle =
  style
    [ ("max-height", "15em"),
      ("flex", "1 0 auto")
    ]
