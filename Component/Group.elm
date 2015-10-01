module Component.Group (Model, init, initWithUsers, Action, update, view) where
import Component.UserList as UserList
import Component.User as User
import Time exposing (second)
import Html exposing (..)

-- MODEL

type alias Model =
  {
    title: String,
    users: UserList.Model,
    createdAt: Time.Time
  }

init : String -> Model
init title =
  {
    title = title,
    users = UserList.init,
    createdAt = Time.second
  }

initWithUsers : String -> List User.Model -> Model
initWithUsers title users =
  {
    title = title,
    users = UserList.initWithUsers users,
    createdAt = Time.second
  }

-- UPDATE

type Action
  = ChangeTitle String
  | ModifyUsers UserList.Action

update : Action -> Model -> Model
update action model =
  case action of
    ChangeTitle newTitle ->
      { model | title <- newTitle }

    ModifyUsers userListAction ->
      { model |
          users <- UserList.update userListAction model.users
      }

view : Signal.Address Action -> Model -> Html
view address model =
  UserList.view (Signal.forwardTo address ModifyUsers) model.users
