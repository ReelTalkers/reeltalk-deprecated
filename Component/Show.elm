module Component.Show (Model, init, view) where

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
    {
      title : String
    }


init : String -> Model
init title =
    {
      title = title
    }


-- VIEW


view : Model -> Html
view model =
  div [titleStyle]
    [
      h2 [] [text model.title]
    ]


titleStyle : Attribute
titleStyle =
  style
    [
      ("text-align", "center")
    ]