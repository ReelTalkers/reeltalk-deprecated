module Component.Review (Model, init, Action, update,
                         view, viewWithRemoveButton, Context) where

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
        div [showInformationColumn]
          [
            h2 [] [text show.title],
            h3 [] [text ("Stars: " ++ (toString model.score))],
            button [ onClick address (UpdateScore 1) ] [ text "1" ],
            button [ onClick address (UpdateScore 2) ] [ text "2" ],
            button [ onClick address (UpdateScore 3) ] [ text "3" ],
            button [ onClick address (UpdateScore 4) ] [ text "4" ],
            button [ onClick address (UpdateScore 5) ] [ text "5" ],
            br [] [],
            span [] [text (show.year ++ " " ++ show.mpaarating ++ " " ++ show.runtime)],
            br [] [],
            span [] [text (show.description)]
          ],
        div [showPosterStyle]
          [
            showPoster
          ]
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

viewWithRemoveButton : Context -> Model -> Html
viewWithRemoveButton context model =
  div [reviewContainer model.show]
    [
      h2 [reviewContainer model.show] [text model.show.title],
      br [] [],
      button [ onClick context.actions (UpdateScore 1) ] [ text "1" ],
      button [ onClick context.actions (UpdateScore 2) ] [ text "2" ],
      button [ onClick context.actions (UpdateScore 3) ] [ text "3" ],
      button [ onClick context.actions (UpdateScore 4) ] [ text "4" ],
      button [ onClick context.actions (UpdateScore 5) ] [ text "5" ],
      br [] [],
      button [ onClick context.remove () ] [ text "X" ]
    ]

reviewContainer : Show.Model -> Attribute
reviewContainer show =
  style
    [ ("background-color", show.color),
      ("display", "flex"),
      ("max-height", "15em"),
      ("flex-direction", "row")
    ]

showInformationColumn : Attribute
showInformationColumn =
  style
    [ ("min-width", "60em")
    ]

showPosterStyle : Attribute
showPosterStyle =
  style
    [ ("margin-left", "auto")
    ]
