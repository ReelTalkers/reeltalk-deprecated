module Page.ReviewPage where

import Component.ReviewList as ReviewList
import Component.User as User

import Html exposing (..)

type alias Model = 
    {
        user : User.Model,
        reviewList : ReviewList.Model 
    }

init : Model
init user reviewList =
    {
        user = user,
        reviewList = reviewList
    }

type Action = 
    NoOp

update: Action -> Model -> Model
update action model =
    case action of
        NoOp ->
            model

view: Signal.Address Action -> Model -> Html
view address model =
  div []
    [
      h1 [] [text "Recommend"],
      ReviewList.view (Signal.forwardTo address ReviewList) model.reviewList
    ]

