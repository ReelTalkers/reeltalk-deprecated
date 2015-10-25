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

type alias ID = Int

type Action = 
    Modify ReviewList.Action

update: Action -> Model -> Model
update action model =
    case action of
        Modify act ->
            { model |
                reviewList <- ReviewList.update act model.reviewList
            }

view: Signal.Address Action -> Model -> Html
view address model =
  div []
    [
      h1 [] [text "Recommend"],
      ReviewList.view (Signal.forwardTo address Modify) model.reviewList
    ]

