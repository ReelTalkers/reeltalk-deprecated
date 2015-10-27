module Component.Page where

import Component.User as User
import Tab.RecommendTab as RecommendTab

import String
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Signal


-- MODEL


type alias Model =
    {
      user : User.Model,
      content : RecommendTab.Model
    }


init : Model
init =
  let
      user = { handle = "gziegan" , firstName = "Greg", lastName = "Ziegan",
               email = "greg.ziegan@gmail.com", phone = "012-345-6789" }
  in
    {
        user = user,
        content = RecommendTab.init user
    }


-- UPDATE

type Action
    = NoOp

update : Action -> Model -> Model
update action model =
    case action of
        NoOp ->
          model


-- VIEW


view addresses model =
  div [ id "page" ]
    [
      RecommendTab.view model.content
    ]
