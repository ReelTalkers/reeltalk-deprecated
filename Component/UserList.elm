module Component.UserList where

import Component.User as User
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Json.Decode as Json

-- MODEL

type alias Model =
  {
    users : List ( ID, User.Model ),
    nextID : ID,
    newUser : User.Model
  }

type alias ID = Int

init : Model
init =
  {
    users = [],
    nextID = 0,
    newUser = User.init "" "" "" "" ""
  }

initWithUsers : List User.Model -> Model
initWithUsers users =
  {
    users = List.indexedMap (\i user -> (i, user)) users,
    nextID = List.length users + 1,
    newUser = User.init "" "" "" "" ""
  }

-- UPDATE

type Action
    = Add
    | UpdateNewUserHandle String
    | Remove ID
    | Modify ID User.Action

update : Action -> Model -> Model
update action model =
  case action of
    Add ->
      { model |
          users <- (model.nextID, User.init model.newUser.handle "" "" "" "") :: model.users,
          nextID <- model.nextID + 1
      }

    UpdateNewUserHandle handle ->
      { model |
          newUser <- User.init handle "" "" "" ""
      }

    Remove id ->
      { model |
          users <- List.filter (\(userID, _) -> userID /= id) model.users
      }

    Modify id userAction ->
      let updateUser (userID, userModel) =
        if userID == id
          then (userID, User.update userAction userModel)
          else (userID, userModel)
      in
          { model | users <- List.map updateUser model.users }


-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  let addUser =
      userSearch address model.newUser
  in
      div [] (addUser :: List.map (viewUser address) model.users)

userSearch : Signal.Address Action -> User.Model -> Html
userSearch address user =
  div [] 
  [
    input [
            id "user-search-handle",
            placeholder "Search for User by handle...",
            autofocus True,
            value user.handle,
            name "userSearch",
            on "input" targetValue (Signal.message address << UpdateNewUserHandle)
          ]
          [],
    button [ onClick address Add ] [ text "Add User" ]
  ]

viewUser : Signal.Address Action -> (ID, User.Model) -> Html
viewUser address (id, model) =
  User.view (Signal.forwardTo address (Modify id)) model

onEnter : Signal.Address a -> a -> Attribute
onEnter address value =
    on "keydown"
      (Json.customDecoder keyCode is13)
      (\_ -> Signal.message address value)

is13 : Int -> Result String ()
is13 code =
  if code == 13 then Ok () else Err "not the right key code"
