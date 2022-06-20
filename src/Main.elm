module Main exposing (main)

import Board
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class)
import Model exposing (Hex(..), Round, RoundProgress(..), RoundType(..))
import Set
import Svg
import Svg.Attributes
import Url


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlRequest = UrlRequested
        , onUrlChange = UrlChanged
        }


rounds : List Round
rounds =
    let
        stockRound =
            Round StockRound NotReached

        buildRound =
            Round BuildRound NotReached
    in
    [ stockRound
    , buildRound
    , stockRound
    , buildRound
    , buildRound
    , stockRound
    , buildRound
    , buildRound
    ]


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    , property : String
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    ( Model key url "modelInitialValue", Cmd.none )


type Msg
    = Msg1
    | Msg2
    | UrlRequested Browser.UrlRequest
    | UrlChanged Url.Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Msg1 ->
            ( model, Cmd.none )

        Msg2 ->
            ( model, Cmd.none )

        UrlRequested urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model, Nav.pushUrl model.key (Url.toString url) )

                Browser.External href ->
                    ( model, Nav.load href )

        UrlChanged url ->
            ( { model | url = url }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "Iberian Gauge"
    , body =
        [ div [ class "h-screen w-screen" ]
            [ Svg.svg [ Svg.Attributes.class "h-full w-full" ]
                []
            ]
        ]
    }
