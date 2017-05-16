port module Main exposing (..)

import Html exposing (..)
import Http exposing (..)
import Json.Decode as Json

main : Program Never Model Msg
main = Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

type alias Model =
    { oauthToken : String
    , screenName : String
    }

type Msg = GetTwitterValue Model

port jsGetTwitterValue : (Model -> msg) -> Sub msg

init : (Model, Cmd Msg)
init = (Model "" "", Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetTwitterValue { oauthToken, screenName } ->
            ({ model | oauthToken = oauthToken, screenName = screenName }, Cmd.none)

view : Model -> Html Msg
view model =
    case model of
        { oauthToken, screenName } ->
            div [] [ text screenName ]

subscriptions : Model -> Sub Msg
subscriptions model = jsGetTwitterValue GetTwitterValue
