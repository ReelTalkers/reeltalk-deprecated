module Component.Show (Model, init, update, view, viewAsPoster, viewAsBanner) where

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
  {
    title : String,
    banner : String,
    poster : String
  }


init : String -> String -> String -> Model
init title banner poster =
  {
    title = title,
    banner = banner,
    poster = poster
  }


-- UPDATE

type Action
  = ChangeTitle String
  | ChangeBanner String
  | ChangePoster String


update : Action -> Model -> Model
update action model =
  case action of
    ChangeTitle newTitle ->
      { model | title <- newTitle }
    ChangeBanner newBanner ->
      { model | banner <- newBanner }
    ChangePoster newPoster ->
      { model | poster <- newPoster }


-- VIEW


view : Signal.Address Action -> Model -> Html
view address model =
  div [centeredStyle]
    [
      h2 [] [text model.title],
      img [src model.poster] []
    ]

viewAsPoster : Signal.Address Action -> Model -> Html
viewAsPoster address model =
  div []
    [
      img [src model.poster] []
    ]

viewAsBanner : Signal.Address Action -> Model -> Html
viewAsBanner address model =
  div []
    [
      img [src model.banner] []
    ]

centeredStyle : Attribute
centeredStyle =
  style
    [
      ("text-align", "center")
    ]