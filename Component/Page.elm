module Component.Page where

import Component.Show as Show
import Component.Review as Review
import Component.User as User
import Tab.RecommendTab as RecommendTab

import String
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Signal
import Signal exposing (Address)

-- MODEL

type alias Addresses a =
  { a |
      requestUser: Address ()
  }

type alias Model =
    {
      user : Maybe User.Model,
      content : Maybe RecommendTab.Model,

      shows : List Show.Model,
      reviews : List Review.Model
    }


init : Model
init =
    {
        user = Nothing,
        content = Nothing,
        shows = [],
        reviews = []
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

view : Addresses a -> Model -> Html
view addresses model =
  div [ id "page" ] <|
    case model.user of
      Nothing ->
        [
          button [onClick addresses.requestUser ()] [text "Login!"]
        ]
      Just user ->
        [
          RecommendTab.view addresses (modelRecommendTab user model)
        ]

modelRecommendTab : User.Model -> Model -> RecommendTab.Model
modelRecommendTab user model =
  {
    user = user,
    shows = model.shows
  }
