import Html exposing (..)
import Html.Events exposing (..)
import Json.Decode exposing (..)

main = Html.beginnerProgram { model = [], update = update, view = view }

update msg = msg

view model = div [] [ text "elm dummy" ]
