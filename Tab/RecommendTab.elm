module Tab.RecommendTab where

import Component.User as User
import Component.Show as Show
import Component.ShowFilter as ShowFilter
import Signal exposing (Address)
import Html exposing (..)

type alias Addresses a =
  { a |
      newReview : Address ()
  }

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

type Action
  = NoOp

update: Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model

view: Addresses a -> Model -> Html
view channels model =
  div []
    [
      h1 [] [text "Recommend"]
    ]
