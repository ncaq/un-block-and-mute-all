port module Main exposing (..)

import Html exposing (..)
import Http exposing (..)

main : Program Never Model Msg
main = Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

type alias Model =
    { screenName : String
    }

type Msg = GetTwitterValue String | GetBlockList (Result Http.Error String)

port jsGetTwitterValue : (String -> msg) -> Sub msg

init : (Model, Cmd Msg)
init = (Model "", Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetTwitterValue screenName ->
            ({ model | screenName = screenName }, Cmd.none)
        _ -> (model, Cmd.none)

view : Model -> Html Msg
view model = div [] [ text ("hello @" ++ model.screenName) ]

subscriptions : Model -> Sub Msg
subscriptions model = jsGetTwitterValue GetTwitterValue
