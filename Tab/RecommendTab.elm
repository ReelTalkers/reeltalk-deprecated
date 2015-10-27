module Tab.RecommendTab where

import Component.User as User
import Component.ShowFilter as ShowFilter

import Html exposing (..)
import Signal exposing (Address, mailbox)

type alias Addresses a =
    { a |
      newReview : Address ()
    }

type alias Model =
  {
    user : User.Model,
    shows : ShowFilter.Model
  }

init: User.Model -> Model
init user =
  {
    user = user,
    shows = ShowFilter.init
  }


view: Addresses a -> Model -> Html
view addresses model =
  div []
    [
      h1 [] [text "Recommended"],
      ShowFilter.view model.shows
    ]
