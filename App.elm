module App where
import Component.ShowList exposing (init, update, view)
import Component.User as User
import Component.Page as Page
import Component.Review as Review
import Component.Show as Show

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

type Action
    = NoOp
    | SetPage Page.Model
    | SetUser (Maybe User.Model)
    | ListReviews (List Review.Model)
    | ListShows (List Show.Model)


update : Action -> AppState -> AppState
update action state =
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

userInput : Signal Action
userInput =
    Signal.mergeMany
        [
          Signal.map SetUser setUser,
          Signal.map ListReviews listReviews,
          Signal.map ListShows listShows,
          actions.signal
        ]

generalizePageUpdate : AppState -> Page.Action -> Action
generalizePageUpdate state pageAction =
    SetPage (Page.update pageAction state.page)

modelPage : AppState -> Page.Model
modelPage state =
    {
      content = state.page.content,
      user = state.page.user,
      shows = state.shows,
      reviews = state.reviews
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

port setUser : Signal (Maybe User.Model)
port listReviews : Signal (List Review.Model)
port listShows : Signal (List Show.Model)

port newReview : Signal ()
port newReview =
  signals.newReview

port requestUser : Signal ()
port requestUser =
  signals.requestUser
