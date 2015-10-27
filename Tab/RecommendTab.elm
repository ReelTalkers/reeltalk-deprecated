module Tab.RecommendTab where

import Component.ShowList as ShowList
import Component.User as User
import Component.Show as Show
import Component.ShowFilter as ShowFilter
import Signal exposing (Address)
import Html exposing (..)
import Html.Attributes exposing (..)

-- MODEL


type alias Model =
  {
    user : User.Model,
    shows : List Show.Model
  }

init: User.Model -> List Show.Model -> Model
init user shows =
  {
    user = user,
    shows = shows
  }


-- UPDATE


type Action
  = NoOp

update: Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model


-- VIEW


view channels model =
  div []
    (h1 [] [text "Recommend"] :: List.map (\show -> img [src show.poster, height 150] []) model.shows)
