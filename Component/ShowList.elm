module Component.ShowList where

import Component.Show as Show
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL

type alias Model =
  {
      shows : List ( ID, Show.Model ),
      nextID : ID
  }

type alias ID = Int

init : Model
init =
  {
      shows = [],
      nextID = 0
  }

-- UPDATE

type Action
    = Insert
    | Remove ID
    | Modify ID Show.Action

update : Action -> Model -> Model
update action model =
  case action of
    Insert ->
      { model |
          shows <- ( model.nextID, Show.init "Cool New Show" 0 ) :: model.shows,
          nextID <- model.nextID + 1
      }

    Remove id ->
      { model |
          shows <- List.filter (\(showID, _) -> showID /= id) model.shows
      }

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
  let insert = button [ onClick address Insert ] [ text "Add" ]
  in
      div [] (insert :: List.map (viewShow address) model.shows)

viewShow : Signal.Address Action -> (ID, Show.Model) -> Html
viewShow address (id, model) =
  let context =
        Show.Context
          (Signal.forwardTo address (Modify id))
          (Signal.forwardTo address (always (Remove id)))
  in
      Show.viewWithRemoveButton context model
