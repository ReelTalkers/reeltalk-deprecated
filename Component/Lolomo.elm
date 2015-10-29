module Component.Lolomo (Model, init, Action, update, view) where

import Component.LolomoRow as LolomoRow
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL
type alias ID = Int

type alias Model =
  {
    rows : List (ID, LolomoRow.Model)
  }

init : List LolomoRow.Model -> Model
init rows =
    {
      rows = List.indexedMap (\i row -> (i, row)) rows
    }

-- UPDATE
type Action
    = NoOp |
      Modify ID LolomoRow.Action

update : Action -> Model -> Model
update action model =
  case action of
    NoOp ->
      model
    Modify id act ->
      let updateRow (rowID, rowModel) =
        if rowID == id
          then (rowID, LolomoRow.update act rowModel)
          else (rowID, rowModel)
      in
        { model | rows <- List.map updateRow model.rows }

--VIEW
view : Signal.Address Action -> Model -> Html
view address model =
      let
        rows = div [] (List.map (viewRow address) model.rows)
      in
        div []
          [
            rows
          ]

viewRow : Signal.Address Action -> (ID, LolomoRow.Model) -> Html
viewRow address (id, model) =
  LolomoRow.view (Signal.forwardTo address (Modify id)) model
