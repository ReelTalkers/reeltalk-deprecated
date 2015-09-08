module Component.User (Model, init, view) where

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
    {
        handle : String,
        firstName : Name,
        lastName : Name,
        email : Email,
        phone : Phone
    }

type alias Name = String
type alias Email = String
type alias Phone = String

init : String -> Name -> Name -> Email -> Phone -> Model
init handle firstName lastName email phone =
    {
        handle = handle,
        firstName = firstName,
        lastName = lastName,
        email = email,
        phone = phone
    }


-- VIEW


view : Model -> Html
view model =
    div []
    [
        h3 [] [ text model.handle ]
    ]
