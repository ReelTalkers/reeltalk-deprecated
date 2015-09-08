module Component.Review (Model, init, Action, update, 
                         view, viewWithRemoveButton, Context) where

import Component.Show as Show
import Component.User as User
import Time exposing (Time, every, second)
import Date exposing (year, hour, minute, second, fromTime)
import Html exposing (..)
import Html.Events exposing (..)


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


type Action = UpdateScore Score

update : Action -> Model -> Model
update action model =
    case action of
        UpdateScore newScore ->
            { model |
                score <- newScore
            }


-- VIEW


view: Signal.Address Action -> Model -> Html
view address model =
    div []
    [
        h2 [] [text model.show.title],
        br [] [],
        button [ onClick address (UpdateScore 1) ] [ text "1" ],
        button [ onClick address (UpdateScore 2) ] [ text "2" ],
        button [ onClick address (UpdateScore 3) ] [ text "3" ],
        button [ onClick address (UpdateScore 4) ] [ text "4" ],
        button [ onClick address (UpdateScore 5) ] [ text "5" ],
        br [] [],
        span [] [text ("Reviewed At: " ++ (currentTime model.createdAt))],
        br [] [],
        span [] [text ("Reviewed By: " ++ (model.user.handle))]
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
    div []
    [
        h2 [] [text model.show.title],
        br [] [],
        button [ onClick context.actions (UpdateScore 1) ] [ text "1" ],
        button [ onClick context.actions (UpdateScore 2) ] [ text "2" ],
        button [ onClick context.actions (UpdateScore 3) ] [ text "3" ],
        button [ onClick context.actions (UpdateScore 4) ] [ text "4" ],
        button [ onClick context.actions (UpdateScore 5) ] [ text "5" ],
        br [] [],
        button [ onClick context.remove () ] [ text "X" ]
    ]