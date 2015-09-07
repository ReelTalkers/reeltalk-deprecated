module Component.Dashboard where

import Component.Show exposing (Score)
import Component.ShowList as ShowList
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

-- MODEL

type alias Model =
  {
      reviewedShows : ShowList.Model,
      suggestedShows : ShowList.Model,
      searchResults : ShowList.Model
  }

init : Model
init =
  {
      reviewedShows = ShowList.init,
      suggestedShows = ShowList.init,
      searchResults = ShowList.init
  }


-- UPDATE


type Action
    = Review ShowList.Action
    | Suggest ShowList.Action
    | Search ShowList.Action


update : Action -> Model -> Model
update action model =
  case action of
    Review showListAction ->
      { model |
          reviewedShows <- ShowList.update showListAction model.reviewedShows
      }
    Suggest showListAction ->
      { model |
          suggestedShows <- ShowList.update showListAction model.suggestedShows
      }
    Search showListAction ->
      { model |
          searchResults <- ShowList.update showListAction model.searchResults
      }


-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  div []
    [
        h2 [] [ text "Reviewed Shows" ],
        ShowList.view (Signal.forwardTo address Review) model.reviewedShows,
        h2 [] [ text "Suggested Shows" ],
        ShowList.view (Signal.forwardTo address Suggest) model.suggestedShows,
        h2 [] [ text "Search Results" ],
        ShowList.view (Signal.forwardTo address Search) model.searchResults
    ]
