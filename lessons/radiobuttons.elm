module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


main : Program Never Model Msg
main =
    Html.beginnerProgram { model = model, view = view, update = update }


type alias Model =
    { fontSize : FontSize
    , content : String
    }


type FontSize
    = Small
    | Medium
    | Large


model : Model
model =
    Model Medium "Lorem Ipsum"


type Msg
    = SwitchTo FontSize


update : Msg -> Model -> Model
update msg model =
    case msg of
        SwitchTo fontSize ->
            { model | fontSize = fontSize }


view : Model -> Html Msg
view model =
    div []
        [ viewPicker
            [ fontSizeModel Small "Small" model
            , fontSizeModel Medium "Medium" model
            , fontSizeModel Large "Large" model
            ]
        , section [ setFontStyle model.fontSize ]
            [ text model.content
            ]
        ]


fontSizeModel : FontSize -> String -> Model -> ( Msg, String, Bool )
fontSizeModel fontSize name model =
    ( (SwitchTo fontSize), name, (model.fontSize == fontSize) )


viewPicker : List ( Msg, String, Bool ) -> Html Msg
viewPicker choices =
    fieldset [] (List.map radiobutton choices)


radiobutton : ( Msg, String, Bool ) -> Html Msg
radiobutton ( msg, name, isChecked ) =
    label []
        [ input [ type_ "radio", onClick msg, checked isChecked ] []
        , text name
        ]


setFontStyle : FontSize -> Attribute msg
setFontStyle fontSize =
    let
        fontSizeValue =
            case fontSize of
                Small ->
                    "0.75em"

                Medium ->
                    "1em"

                Large ->
                    "2em"
    in
        style [ ( "font-size", fontSizeValue ) ]
