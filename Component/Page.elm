module Component.Page where

import Component.User as User
import Component.Show as Show
import Component.Review as Review

import Component.LoggedOutPage as LoggedOutPage
import Component.LoggedInPage as LoggedInPage

import Html exposing (..)
import Html.Attributes exposing (..)

type alias Model =
  {
    user : Maybe User.Model,
    shows : List Show.Model,
    reviews : List Review.Model
  }

initialModel : Model
initialModel =
  {
    user = Nothing,
    shows = [],
    reviews = []
  }

type Update
  = NoOp

transition : Update -> Model -> Model
transition update model =
  case update of
    NoOp ->
      model

view addresses model =
  div [ id "page" ] <|
    case model.user of
      Nothing ->
        [ LoggedOutPage.view addresses ]
      Just user ->
        [ LoggedInPage.view addresses (LoggedInPage.init user model.shows model.reviews) ]
