module Component.LoggedOutPage where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

view addresses =
  div [] [
    button [onClick addresses.requestUser ()] [text "Login!"]
  ]
