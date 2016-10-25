import Char exposing (..)

import Html exposing (..)
import Html.App as App
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

import String

main = App.beginnerProgram { model = model, view = view, update = update }


-- Model

type alias Model = {
  name : String,
  age: Int,
  password : String,
  passwordAgain : String
}

model: Model
model = Model "toto" 0 "" ""


-- Update

type Msg
  = Name String
  | Age String
  | Password String
  | PasswordAgain String

update: Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }
    Age age ->
      { model | age = Result.withDefault 0 (String.toInt age) }
    Password password ->
      { model | password = password }
    PasswordAgain password ->
      { model | passwordAgain = password }


-- View

view: Model -> Html Msg
view model =
  div [] [
    input [ type' "text", placeholder "Name", onInput Name ] [],
    input [ type' "number", placeholder "Age", onInput Age ] [],
    input [ type' "password", placeholder "Password", onInput Password ] [],
    input [ type' "password", placeholder "Confirm Password", onInput PasswordAgain ] [],
    viewValidation model
  ]

viewValidation: Model -> Html Msg
viewValidation model =
  let (color, message) =
    if not (String.any isDigit model.password && String.any isUpper model.password && String.any isLower model.password) then
      ("red", "Password should contain mix cases and digits")
    else if String.length model.password <= 8 then
      ("red", "Password should have at least 9 characters")
    else if model.password /= model.passwordAgain then
      ("red", "Passwords do not match!")
    else
      ("green", "OK")
  in
    div [ style [("color", color)]] [ text message ]
