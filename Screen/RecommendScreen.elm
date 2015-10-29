module Screen.RecommendScreen where

import Component.User as User
import Component.Show as Show
import Signal exposing (Address)
import Html exposing (..)
import Html.Attributes exposing (..)

-- MODEL


type alias Model =
  {
    user : User.Model,
    shows : List Show.Model
  }

init : User.Model -> List Show.Model -> Model
init user shows =
  {
    user = user,
    shows = shows
  }


-- UPDATE


type Update
  = NoOp

transition : Update -> Model -> Model
transition update model =
  case update of
    NoOp ->
      model


-- VIEW


view channels model =
  div []
    (h1 [] [text "Recommend"] :: List.map (\show -> img [src show.poster, height 150] []) model.shows)
