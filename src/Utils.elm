module Utils exposing (..)

import Html exposing (Attribute)
import Html.Attributes exposing (classList)


classes : List String -> Attribute msg
classes =
    classList << List.map (\x -> ( x, True ))
