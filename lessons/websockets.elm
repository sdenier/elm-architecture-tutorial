module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import WebSocket


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { input : String
    , messages : List String
    }


type Msg
    = Input String
    | Send
    | NewMessage String


init : ( Model, Cmd Msg )
init =
    ( Model "" [], Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Input input ->
            ( { model | input = input }, Cmd.none )

        Send ->
            ( model, WebSocket.send "ws://echo.websocket.org" model.input )

        NewMessage message ->
            ( { model | messages = model.messages ++ [ message ] }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    WebSocket.listen "ws://echo.websocket.org" NewMessage


view : Model -> Html Msg
view model =
    div []
        [ div [] (List.map viewMessage model.messages)
        , input [ onInput Input ] []
        , button [ onClick Send ] [ text "Send" ]
        ]


viewMessage : String -> Html Msg
viewMessage msg =
    div [] [ text msg ]
