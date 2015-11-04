module Component.LolomoRow (Model, init, Action, update, view) where

import Component.Show as Show
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json

-- MODEL

type alias Model =
  {
    shows : List ( ID, Show.Model ),
    genre : String
  }

type alias ID = Int

init : String -> List Show.Model -> Model
init genre shows =
  {
    shows = List.indexedMap (\i show -> (i, show)) shows,
    genre = genre
  }

-- UPDATE

type Action
    = NoOp |
    Modify ID Show.Action

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    Modify id showAction ->
      let updateShow (showID, showModel) =
        if showID == id
          then (showID, Show.update showAction showModel)
          else (showID, showModel)
      in
          { model | shows <- List.map updateShow model.shows }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
      let
        shows = div [showListStyle] (List.map (viewShow address) model.shows)
      in
        div [lolomoRowStyle]
          [
            h2 [headerStyle] [text model.genre],
            shows
          ]

viewShow : Signal.Address Action -> (ID, Show.Model) -> Html
viewShow address (id, model) =
  Show.view (Signal.forwardTo address (Modify id)) model

lolomoRowStyle : Attribute
lolomoRowStyle =
  style
    [ ("display", "flex"),
      ("flex-direction", "column")
    ]

headerStyle : Attribute
headerStyle =
  style
    [ ("align-self", "center")
    ]

showListStyle : Attribute
showListStyle =
  style
    [ ("display", "flex"),
      ("flex-direction", "row")
    ]
