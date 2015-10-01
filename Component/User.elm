module Component.User (Model, init, Action, update, view) where

import Html exposing (..)

-- MODEL

type alias Model =
  {
    handle : Handle,
    firstName : Name,
    lastName : Name,
    email : Email,
    phone : Phone
  }

type alias Handle = String
type alias Name = String
type alias Email = String
type alias Phone = String

init : Handle -> Name -> Name -> Email -> Phone -> Model
init handle firstName lastName email phone =
    {
        handle = handle,
        firstName = firstName,
        lastName = lastName,
        email = email,
        phone = phone
    }

-- UPDATE

type Action
  = ChangeHandle Handle
  | ChangeFirstName Name
  | ChangeLastName Name
  | ChangeEmail Email
  | ChangePhone Phone


update : Action -> Model -> Model
update action model =
  case action of
    ChangeHandle newHandle ->
      { model | handle <- newHandle }
    ChangeFirstName newFirstName ->
      { model | firstName <- newFirstName }
    ChangeLastName newLastName ->
      { model | lastName <- newLastName }
    ChangeEmail newEmail ->
      { model | email <- newEmail }
    ChangePhone newPhone ->
      { model | phone <- newPhone }

-- VIEW

view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [
      h3 [] [ text model.handle ]
    ]
