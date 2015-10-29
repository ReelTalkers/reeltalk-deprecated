module Component.Show (Model, init, Action, update, view, viewAsPoster, viewAsBanner) where

import Html exposing (..)
import Html.Attributes exposing (..)


-- MODEL


type alias Model =
  {
    title : String,
    banner : String,
    poster : String,
    color : String,
    textColor : String,
    year : String,
    mpaarating : String,
    runtime : String,
    description : String
  }


init : String -> String -> String -> String -> String -> String -> String -> String -> String -> Model
init title banner poster color textColor year mpaarating runtime description =
  {
    title = title,
    banner = banner,
    poster = poster,
    color = color,
    textColor = textColor,
    year = year,
    mpaarating = mpaarating,
    runtime = runtime,
    description = description
  }


-- UPDATE

type Action
  = ChangeTitle String
  | ChangeBanner String
  | ChangePoster String
  | NoOp


update : Action -> Model -> Model
update action model =
  case action of
    ChangeTitle newTitle ->
      { model | title <- newTitle }
    ChangeBanner newBanner ->
      { model | banner <- newBanner }
    ChangePoster newPoster ->
      { model | poster <- newPoster }
    NoOp ->
      model


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
