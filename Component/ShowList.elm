module Component.ShowList (Model, init, Action, update, view) where

import Component.Show as Show
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json


-- MODEL

type alias Model =
  {
      shows : List ( ID, Show.Model ),
      nextID : ID,
      newShowTitle : String
  }

type alias ID = Int

init : Model
init =
  {
      shows = [],
      nextID = 0,
      newShowTitle = ""
  }

-- UPDATE

type Action
    = Add
    | UpdateNewShowTitle String
    | Remove ID
    | Modify ID Show.Action

update : Action -> Model -> Model
update action model =
  case action of
    Add ->
      { model |
          shows <- ( model.nextID, Show.init model.newShowTitle 5) :: model.shows,
          nextID <- model.nextID + 1
      }

    UpdateNewShowTitle title ->
      { model |
          newShowTitle <- title
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
  div [] (showEntry address model.newShowTitle :: List.map (viewShow address) model.shows)

showEntry : Signal.Address Action -> String -> Html
showEntry address title =
  input [
          id "new-show",
          placeholder "New Show",
          autofocus True,
          value title,
          name "newShow",
          on "input" targetValue (Signal.message address << UpdateNewShowTitle),
          onEnter address Add
        ]
        []

viewShow : Signal.Address Action -> (ID, Show.Model) -> Html
viewShow address (id, model) =
  let context =
        Show.Context
          (Signal.forwardTo address (Modify id))
          (Signal.forwardTo address (always (Remove id)))
  in
      Show.viewWithRemoveButton context model

onEnter : Signal.Address a -> a -> Attribute
onEnter address value =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (\_ -> Signal.message address value)

is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"
