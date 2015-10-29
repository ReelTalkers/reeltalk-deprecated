module Tab.LolomoTestTab where

import Component.User as User
import Component.Show as Show
import Component.LolomoRow as LolomoRow
import Signal exposing (Address)
import Html exposing (..)
import Html.Attributes exposing (..)

-- MODEL


type alias Model =
  {
    user : User.Model,
    shows : LolomoRow.Model
  }

init: User.Model -> LolomoRow.Model -> Model
init user shows =
  {
    user = user,
    shows = shows
  }


-- UPDATE


type Action
  = NoOp |
    Modify LolomoRow.Action

update: Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    Modify act ->
        { model |
            shows <- LolomoRow.update act model.shows
        }

-- VIEW


view: Signal.Address Action -> Model -> Html
view address model =
  div []
    [
      h1 [headerStyle] [text "Recommend"],
      LolomoRow.view (Signal.forwardTo address Modify) model.shows

    ]

headerStyle: Attribute
headerStyle =
  style
    [ ("background-color", "#cfd8dc")
    ]
