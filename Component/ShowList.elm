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
      newShow : Show.Model
  }

type alias ID = Int

init : Model
init =
  {
      shows = [],
      nextID = 0,
      newShow = Show.init "" 0
  }

-- UPDATE

type Action
    = Add
    | UpdateNewShowTitle String
    | UpdateNewShowScore Show.Score
    | Remove ID
    | Modify ID Show.Action

update : Action -> Model -> Model
update action model =
  case action of
    Add ->
      { model |
          shows <- ( model.nextID, Show.init model.newShow.title model.newShow.score) :: model.shows,
          nextID <- model.nextID + 1
      }

    UpdateNewShowTitle title ->
      { model |
          newShow <- Show.init title model.newShow.score
      }

    UpdateNewShowScore score ->
      { model |
          newShow <- Show.init model.newShow.title score
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
  let reviewShow =
      showEntry address model.newShow
  in
      div [] (reviewShow :: List.map (viewShow address) model.shows)

showEntry : Signal.Address Action -> Show.Model -> Html
showEntry address show =
  div [] [
    input [
            id "new-show-title",
            placeholder "New Show Title",
            autofocus True,
            value show.title,
            name "newShowTitle",
            on "input" targetValue (Signal.message address << UpdateNewShowTitle)
          ]
          [],
    br [] [],
    button [ onClick address (UpdateNewShowScore 1) ] [ text "1" ],
    button [ onClick address (UpdateNewShowScore 2) ] [ text "2" ],
    button [ onClick address (UpdateNewShowScore 3) ] [ text "3" ],
    button [ onClick address (UpdateNewShowScore 4) ] [ text "4" ],
    button [ onClick address (UpdateNewShowScore 5) ] [ text "5" ],
    br [] [],
    button [ onClick address Add ] [ text "Review" ]
  ]

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
