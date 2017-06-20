port module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Http exposing (..)
import Json.Decode as J

main : Program Never Model Msg
main = Html.program { init = init, view = view, update = update, subscriptions = subscriptions }

type alias Model =
    { screenName : String
    , blockIds : List Int
    }

type Msg = GetTwitterValue String | GetBlocks (Result Http.Error (List Int))

port jsGetTwitterValue : (String -> msg) -> Sub msg

init : (Model, Cmd Msg)
init = (Model "" [], getBlocks)

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        GetTwitterValue screenName ->
            ({ model | screenName = screenName }, Cmd.none)
        GetBlocks (Ok blockIds) ->
            ({ model | blockIds = blockIds}, Cmd.none)
        _ -> (model, Cmd.none)

view : Model -> Html Msg
view model = div [] [
              text ("welcome @" ++ model.screenName),
              ul [] (List.map (\i -> li [] [
                                      (text (toString i))
                                     ]) model.blockIds)
             ]

subscriptions : Model -> Sub Msg
subscriptions model = jsGetTwitterValue GetTwitterValue

getBlocks : Cmd Msg
getBlocks = Http.send GetBlocks (Http.get "/blocks" (J.list J.int))
