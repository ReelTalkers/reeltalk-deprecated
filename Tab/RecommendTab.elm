module Tab.RecommendTab where

import Component.User as User
import Component.ShowFilter as ShowFilter

import Html exposing (..)

type alias Model =
  {
    user : User.Model,
    shows : ShowFilter.Model
  }

init: User.Model -> Model
init user =
  {
    user = user,
    shows = ShowFilter.init
  }

type Action
  = FilterShows ShowFilter.Action

update: Action -> Model -> Model
update action model =
  case action of
    FilterShows act ->
      { model |
          shows <- ShowFilter.update act model.shows
      }

view: Model -> Html
view model =
  div []
    [
      h1 [] [text "Recommend"],
      ShowFilter.view model.shows
    ]
