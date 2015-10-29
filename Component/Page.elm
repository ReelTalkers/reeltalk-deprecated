module Component.Page where

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
      recommendScreen : Maybe RecommendScreen.Model,
      reviewsScreen : Maybe ReviewsScreen.Model,

      user : Maybe User.Model,
      shows : List Show.Model,
      reviews : List Review.Model
    }


init : Model
init =
    {
        recommendScreen = Nothing,
        reviewsScreen = Nothing,

        user = Nothing,
        shows = [],
        reviews = []
    }


-- UPDATE


type Update
    = NoOp
    | UpdateReviewsScreen ReviewsScreen.Update

transition : Update -> Model -> Model
transition update model =
    case update of
        NoOp ->
          model
        UpdateReviewsScreen act ->
          model

-- VIEW

view addresses model =
  div [ id "page" ]
    [
      div [class "mdl-tabs mdl-js-tabs mdl-js-ripple-effect"] <|
        case model.user of
          Nothing ->
            viewLoggedOut addresses model

          Just user ->
            viewLoggedIn addresses user model

    ]

viewLoggedOut addresses model =
  [
    button [onClick addresses.requestUser ()] [text "Login!"]
  ]

viewLoggedIn addresses user model =
  let
      updateReviewsScreen =
        Signal.forwardTo addresses.update UpdateReviewsScreen

      recommendScreenChannels = addresses

      reviewsScreenChannels =
        { addresses | update <- updateReviewsScreen }
  in
      [
        div [class "mdl-tabs__tab-bar"]
          [
            a [href "#recommend-panel", class "mdl-tabs__tab is_active"] [text "Recommend"],
            a [href "#reviews-panel", class "mdl-tabs__tab"] [text "Reviews"]
          ],
        div [class "mdl-tabs__panel is-active", id "recommend-panel"]
          [
            RecommendScreen.view recommendScreenChannels (modelRecommendScreen user model)
          ],
        div [class "mdl-tabs__panel", id "reviews-panel"]
          [
            ReviewsScreen.view reviewsScreenChannels (modelReviewsScreen user model)
          ]
      ]

modelRecommendScreen : User.Model -> Model -> RecommendScreen.Model
modelRecommendScreen user model =
  {
    user = user,
    shows = model.shows
  }

modelReviewsScreen : User.Model -> Model -> ReviewsScreen.Model
modelReviewsScreen user model =
  {
    user = user,
    reviewList = ReviewList.initWithReviews model.reviews
  }
