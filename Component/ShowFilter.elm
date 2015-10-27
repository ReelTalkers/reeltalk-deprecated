module Component.ShowFilter where

import Component.ShowList as ShowList
import Component.Group as Group
import Component.User as User

import Html exposing (..)

-- MODEL

type alias Model =
  {
    shows : ShowList.Model,
    groups : List Group.Model,
    users : List User.Model
  }


init : Model
init =
  {
    shows = ShowList.init,  -- eventually entire show list
    groups = [],
    users = []
  }

initWithGroups : List Group.Model -> Model
initWithGroups groups =
  {
    shows = ShowList.init,
    groups = groups,
    users = []
  }

initWithUsers : List User.Model -> Model
initWithUsers users =
  {
    shows = ShowList.init,
    groups = [],
    users = users
  }

initWithGroupsAndUsers : List Group.Model -> List User.Model -> Model
initWithGroupsAndUsers groups users =
  {
    shows = ShowList.init,
    groups = groups,
    users = users
  }

-- UPDATE

type Action
  = FilterShows

update : Action -> Model -> Model
update action model =
  case action of
    FilterShows ->
      { model |
          shows <- filterShows model.groups model.users model.shows
      }

filterShows : List Group.Model -> List User.Model -> ShowList.Model -> ShowList.Model
filterShows groups users showList =
  showList

-- VIEW

view : Model -> Html
view model =
  div []
    [
      p [] [text "filter"]
    ]
