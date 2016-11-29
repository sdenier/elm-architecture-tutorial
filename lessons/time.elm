module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (Time, second)


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { time : Time
    , paused : Bool
    }


type Msg
    = Tick Time
    | StartStop


init : ( Model, Cmd Msg )
init =
    ( { time = 0, paused = False }, Cmd.none )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Tick newTime ->
            ( { model | time = newTime }, Cmd.none )

        StartStop ->
            ( { model | paused = not model.paused }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    if model.paused then
        Sub.none
    else
        Time.every second Tick


view : Model -> Html Msg
view model =
    let
        btnText =
            if model.paused then
                "Start"
            else
                "Pause"

        angleSec =
            turns (Time.inMinutes model.time)

        angleMin =
            turns (Time.inHours model.time)

        ( handX, handY ) =
            ( toString (50 + 40 * sin angleSec), toString (50 - 40 * cos angleSec) )

        ( handMinX, handMinY ) =
            ( toString (50 + 30 * sin angleMin), toString (50 - 30 * cos angleMin) )
    in
        div []
            [ button [ onClick StartStop ] [ Html.text btnText ]
            , br [] []
            , svg [ viewBox "0 0 100 100", width "300px" ]
                [ circle [ cx "50", cy "50", r "45", fill "#0B79CE" ] []
                , line [ x1 "50", y1 "50", x2 handX, y2 handY, stroke "#023963" ] []
                , line [ x1 "50", y1 "50", x2 handMinX, y2 handMinY, stroke "#023963" ] []
                ]
            ]
