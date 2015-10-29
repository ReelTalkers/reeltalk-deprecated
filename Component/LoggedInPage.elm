module Component.LoggedInPage where

import Component.Show as Show
import Component.Review as Review
import Component.ReviewList as ReviewList
import Component.User as User

import Screen.RecommendScreen as RecommendScreen
import Screen.ReviewsScreen as ReviewsScreen

import String
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Signal
import Signal exposing (Address)

-- MODEL


type alias Model =
    {
      recommendScreen : RecommendScreen.Model,
      reviewsScreen : ReviewsScreen.Model,

      user : User.Model,
      shows : List Show.Model,
      reviews : List Review.Model
    }


init : User.Model -> List Show.Model -> List Review.Model -> Model
init user shows reviews =
    {
        recommendScreen = RecommendScreen.init user shows,
        reviewsScreen = ReviewsScreen.init user (ReviewList.initWithReviews reviews),
        user = user,
        shows = shows,
        reviews = reviews
    }


-- UPDATE


type Update
    = NoOp
    | UpdateReviewsScreen ReviewsScreen.Model

transition : Update -> Model -> Model
transition update model =
    case update of
        NoOp ->
          model
        UpdateReviewsScreen childModel ->
          { model |
              reviewsScreen <- childModel
          }

-- VIEW

view addresses model =
  let
      updateReviewsScreen =
        Signal.forwardTo
            addresses.update
            (generalizeReviewsScreenUpdate model)

      reviewsScreenChannels =
        { addresses | update <- updateReviewsScreen }

      recommendScreenChannels = addresses
  in
      div []
        [
          div [class "mdl-tabs mdl-js-tabs mdl-js-ripple-effect"]
            [
              div [class "mdl-tabs__tab-bar"]
                [
                  a [href "#recommend-panel", class "mdl-tabs__tab"] [text "Recommend"],
                  a [href "#reviews-panel", class "mdl-tabs__tab is-active"] [text "Reviews"]
                ],
              div [class "mdl-tabs__panel", id "recommend-panel"]
                [
                  RecommendScreen.view recommendScreenChannels (modelRecommendScreen model)
                ],
              div [class "mdl-tabs__panel is-active", id "reviews-panel"]
                [
                  ReviewsScreen.view reviewsScreenChannels (modelReviewsScreen model)
                ]
            ]
        ]


modelRecommendScreen : Model -> RecommendScreen.Model
modelRecommendScreen model =
  {
    user = model.user,
    shows = model.shows
  }

modelReviewsScreen : Model -> ReviewsScreen.Model
modelReviewsScreen model =
  {
    user = model.user,
    reviewList = ReviewList.initWithReviews model.reviews
  }

generalizeReviewsScreenUpdate : Model -> ReviewsScreen.Update -> Update
generalizeReviewsScreenUpdate model reviewsScreenUpdate =
  UpdateReviewsScreen (ReviewsScreen.transition reviewsScreenUpdate model.reviewsScreen)
