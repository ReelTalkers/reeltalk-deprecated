module Tab.ReviewTab where

import Component.ReviewList as ReviewList
import Component.User as User

import Html exposing (..)

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

type Action = 
    NoOp |
    AddReview ReviewList.Action

update: Action -> Model -> Model
update action model =
    case action of
        NoOp ->
            model
        AddReview act ->
            { model |
                reviewList <- ReviewList.update act model.reviewList
            }

view: Signal.Address Action -> Model -> Html
view address model =
  div []
    [
      h1 [] [text "Recommend"],
      ReviewList.view (Signal.forwardTo address AddReview) model.reviewList
    ]

