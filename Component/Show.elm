module Component.Show (Model, init, Action, update, view, viewWithRemoveButton, Context) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL

type alias Model =
    {
      title : String,
      score : Score
    }

type alias Score = Int

init : String -> Score -> Model
init title score =
    {
      title = title,
      score = score
    }

-- UPDATE

type Action = Review Score

update : Action -> Model -> Model
update action model =
  case action of
    Review newScore ->
      { model |
          score <- newScore
      }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div [titleStyle]
    [
      h2 [] [text model.title],
      span [scoreStyle] [text (toString model.score)]
    ]

type alias Context =
    {
      actions : Signal.Address Action,
      remove : Signal.Address ()
    }

viewWithRemoveButton : Context -> Model -> Html
viewWithRemoveButton context model =
  div []
    [
      div [titleStyle]
        [
          h2 [] [text model.title],
          span [scoreStyle] [text (toString model.score)]
        ],
      button [ onClick context.remove () ] [ text "X" ]
    ]

titleStyle : Attribute
titleStyle =
  style
    [
      ("text-align", "center")
    ]


scoreStyle : Attribute
scoreStyle =
  style
    [
      ("font-size", "14px")
    ]
