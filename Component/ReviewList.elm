module Component.ReviewList (Model, init, initWithReviews, Action, update, view) where


import Component.Review as Review

import Html exposing (..)

-- MODEL

type alias Model =
  {
    reviews : List ( ID, Review.Model )
  }

type alias ID = Int

init : Model
init =
    {
        reviews = []
    }

initWithReviews : List Review.Model -> Model
initWithReviews reviews =
    {
        reviews = List.indexedMap (\i review -> (i, review)) reviews
    }

-- UPDATE

type Action
    = Modify ID Review.Action

update : Action -> Model -> Model
update action model =
    case action of
        Modify id reviewAction ->
            let updateReview (reviewID, reviewModel) =
                if reviewID == id
                    then (reviewID, Review.update reviewAction reviewModel)
                    else (reviewID, reviewModel)
            in
                { model | reviews <- List.map updateReview model.reviews }

-- VIEW
view : Signal.Address Action -> Model -> Html
view address model =
    div [] (List.map (viewReview address) model.reviews)

viewReview : Signal.Address Action -> (ID, Review.Model) -> Html
viewReview address (id, model) =
  Review.view (Signal.forwardTo address (Modify id)) model
