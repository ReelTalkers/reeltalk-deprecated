module App where
import Component.ShowList exposing (init, update, view)
import Component.Page as Page
import Component.Review as Review

import ReelTalk.Mailboxes as Mailboxes
import ReelTalk.Mailboxes exposing (signals, addresses)

import Html exposing (..)
import Signal


-- UPDATE --


actions : Signal.Mailbox Action
actions =
    Signal.mailbox NoOp

type alias AppState =
    {
      page : Page.Model,
      reviews: List Review.Model
    }


initialState : AppState
initialState =
    {
      page = Page.init,
      reviews = []
    }

type Action
    = NoOp
    | SetPage Page.Model
    | ListReviews (List Review.Model)


update : Action -> AppState -> AppState
update action state =
    case action of
        NoOp ->
            state
        SetPage model ->
          { state |
              page <- model
          }
        ListReviews reviews ->
          { state |
              reviews <- reviews
          }

-- VIEW


main : Signal Html
main =
    Signal.map scene state

userInput : Signal Action
userInput =
    Signal.mergeMany
        [
          Signal.map ListReviews listReviews,
          actions.signal
        ]

generalizePageUpdate : AppState -> Page.Action -> Action
generalizePageUpdate state pageAction =
    SetPage (Page.update pageAction state.page)

modelPage : AppState -> Page.Model
modelPage state =
    {
      content = state.page.content,
      user = state.page.user
    }

scene : AppState -> Html
scene state =
    let
        pageUpdate =
            Signal.forwardTo actions.address (generalizePageUpdate state)

        addresses =
            Mailboxes.addresses

    in
        Page.view { addresses | update = pageUpdate } (modelPage state)

state : Signal AppState
state =
    Signal.foldp update initialState userInput

-- PORTS --

port listReviews : Signal (List Review.Model)

port newReview : Signal ()
port newReview =
  signals.newReview
