module App where
import Component.User as User
import Component.Page as Page
import Component.Review as Review
import Component.Show as Show
import Component.ReviewList as ReviewList

import Screen.RecommendScreen as RecommendScreen
import Screen.ReviewsScreen as ReviewsScreen

import ReelTalk.Mailboxes as Mailboxes
import ReelTalk.Mailboxes exposing (signals, addresses)

import Html exposing (..)
import Signal


-- UPDATE --


updates : Signal.Mailbox Update
updates =
    Signal.mailbox NoOp

type alias AppState =
    {
      page : Page.Model,
      reviews : List Review.Model,
      shows : List Show.Model,
      user : Maybe User.Model
    }


initialState : AppState
initialState =
    {
      page = Page.init,
      reviews = [],
      shows = [],
      user = Nothing
    }

type Update
    = NoOp
    | SetPage Page.Model
    | SetUser (Maybe User.Model)
    | ListReviews (List Review.Model)
    | ListShows (List Show.Model)


transition : Update -> AppState -> AppState
transition action state =
    case action of
        NoOp ->
            state
        SetPage model ->
          { state |
              page <- model
          }
        SetUser user ->
          { state |
              user <- user
          }
        ListReviews reviews ->
          { state |
              reviews <- reviews
          }
        ListShows shows ->
          { state |
              shows <- shows
          }


-- VIEW


main : Signal Html
main =
    Signal.map scene state

userInput : Signal Update
userInput =
    Signal.mergeMany
        [
          Signal.map SetUser setUser,
          Signal.map ListReviews listReviews,
          Signal.map ListShows listShows,
          updates.signal
        ]

generalizePageUpdate : AppState -> Page.Update -> Update
generalizePageUpdate state pageUpdate =
    SetPage (Page.transition pageUpdate state.page)

modelPage : AppState -> Page.Model
modelPage state =
  case state.user of
    Nothing ->
      {
        recommendScreen = Nothing,
        reviewsScreen = Nothing,
        user = state.user,
        shows = state.shows,
        reviews = state.reviews
      }
    Just user ->
      {
        recommendScreen = Just (RecommendScreen.init user state.shows),
        reviewsScreen = Just (ReviewsScreen.init user (ReviewList.initWithReviews state.reviews)),
        user = state.user,
        shows = state.shows,
        reviews = state.reviews
      }

scene : AppState -> Html
scene state =
    let
        pageUpdate =
            Signal.forwardTo updates.address (generalizePageUpdate state)

        addresses =
            Mailboxes.addresses

    in
        Page.view { addresses | update = pageUpdate } (modelPage state)

state : Signal AppState
state =
    Signal.foldp transition initialState userInput


-- PORTS --


port setUser : Signal (Maybe User.Model)
port listReviews : Signal (List Review.Model)
port listShows : Signal (List Show.Model)

port newReview : Signal ()
port newReview =
  signals.newReview

port requestUser : Signal ()
port requestUser =
  signals.requestUser
