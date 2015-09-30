module Component.ShowList (Model, init, initWithShows, Action, update, view) where

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
    newShow = Show.init "" "" ""
  }

initWithShows : List Show.Model -> Model
initWithShows shows =
  {
    shows = List.indexedMap (\i show -> (i, show)) shows,
    nextID = List.length shows + 1,
    newShow = Show.init "" "" ""
  }

-- UPDATE

type Action
    = Add
    | UpdateNewShowTitle String
    | UpdateNewShowBanner String
    | UpdateNewShowPoster String
    | Remove ID
    | Modify ID Show.Action

update : Action -> Model -> Model
update action model =
  case action of
    Add ->
      { model |
          shows <- (model.nextID, Show.init model.newShow.title model.newShow.banner model.newShow.poster) :: model.shows,
          nextID <- model.nextID + 1
      }

    UpdateNewShowTitle title ->
      { model |
          newShow <- Show.init title model.newShow.banner model.newShow.poster
      }

    UpdateNewShowBanner banner ->
      { model |
          newShow <- Show.init model.newShow.title banner model.newShow.poster
      }

    UpdateNewShowPoster poster ->
      { model |
          newShow <- Show.init model.newShow.title model.newShow.banner poster
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
  div [] 
  [
    input [
            id "new-show-title",
            placeholder "New Show Title",
            autofocus True,
            value show.title,
            name "newShowTitle",
            on "input" targetValue (Signal.message address << UpdateNewShowTitle)
          ]
          [],
    button [ onClick address Add ] [ text "Review" ]
  ]

viewShow : Signal.Address Action -> (ID, Show.Model) -> Html
viewShow address (id, model) =
  Show.view (Signal.forwardTo address (Modify id)) model

onEnter : Signal.Address a -> a -> Attribute
onEnter address value =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (\_ -> Signal.message address value)

is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"
