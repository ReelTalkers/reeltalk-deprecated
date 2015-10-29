module Tab.LolomoTestTab where

import Component.User as User
import Component.Show as Show
import Component.Lolomo as Lolomo
import Signal exposing (Address)
import Html exposing (..)
import Html.Attributes exposing (..)

-- MODEL


type alias Model =
  {
    user : User.Model,
    lolomo : Lolomo.Model
  }

init: User.Model -> Lolomo.Model -> Model
init user lolomo =
  {
    user = user,
    lolomo = lolomo
  }


-- UPDATE


type Action
  = NoOp |
    Modify Lolomo.Action

update: Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    Modify act ->
        { model |
            lolomo <- Lolomo.update act model.lolomo
        }

-- VIEW


view: Signal.Address Action -> Model -> Html
view address model =
  div []
    [
      h1 [headerStyle] [text "Recommend"],
      Lolomo.view (Signal.forwardTo address Modify) model.lolomo

    ]

headerStyle: Attribute
headerStyle =
  style
    [ ("background-color", "#cfd8dc")
    ]
