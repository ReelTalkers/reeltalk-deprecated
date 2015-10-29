module Screen.ReviewsScreen where

import Component.ReviewList as ReviewList
import Component.User as User

import Html exposing (..)
import Signal exposing (Address)

type alias Addresses a =
  { a |
      update : Address Update
  }

type alias Model =
    {
        user : User.Model,
        reviewList : ReviewList.Model
    }

init : User.Model -> ReviewList.Model -> Model
init user reviewList =
    {
        user = user,
        reviewList = reviewList
    }

type alias ID = Int

type Update =
    Modify ReviewList.Action

transition : Update -> Model -> Model
transition update model =
    case update of
        Modify act ->
            { model |
                reviewList <- ReviewList.update act model.reviewList
            }

view : Addresses a -> Model -> Html
view addresses model =
  div []
    [
      h1 [] [text "Reviews"],
      ReviewList.view (Signal.forwardTo addresses.update Modify) model.reviewList
    ]
