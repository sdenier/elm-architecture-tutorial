import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

main = App.beginnerProgram { model = model, view = view, update = update }


-- Model

type alias Model = {
  name : String,
  password : String,
  passwordAgain : String
}

model: Model
model = Model "toto" "" ""


-- Update

type Msg
  = Name String
  | Password String
  | PasswordAgain String

update: Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    Password password ->
      { model | password = password }
    PasswordAgain password ->
      { model | passwordAgain = password }


-- View

view: Model -> Html Msg
view model =
  div [] [
    input [ type' "text", placeholder "Name", onInput Name ] [],
    input [ type' "password", placeholder "Password", onInput Password ] [],
    input [ type' "password", placeholder "Confirm Password", onInput PasswordAgain ] [],
    viewValidation model
  ]

viewValidation: Model -> Html Msg
viewValidation model =
  let (color, message) =
    if model.password == model.passwordAgain then
      ("green", "Password ok")
    else
      ("red", "Password does not match")
  in
    div [ style [("color", color)]] [ text message ]
