module Main exposing (main)

import Board
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class)
import Model exposing (Hex(..), Occupied(..), Round, RoundProgress(..), RoundType(..))
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


hexRow : Int -> List (Occupied Hex) -> Html Msg
hexRow row hs =
    Html.div
        [ Html.Attributes.attribute "data-row-num" (String.fromInt row)
        , Html.Attributes.class "flex space-x-[46px]"
        , Html.Attributes.classList [ ( "ml-[71px]", modBy 2 row /= 0 ), ( "mt-[-43px]", row /= 0 ) ]
        ]
        (List.map
            (\d ->
                case d of
                    Empty ->
                        Board.emptyHex

                    Occupied h ->
                        Board.hex [ class "hover:scale-150 hover:z-20" ] h
            )
            hs
        )


view : Model -> Browser.Document Msg
view model =
    { title = "Iberian Gauge"
    , body =
        [ div [ class "h-screen w-screen" ] <|
            [ Html.div [ class "scale-50 origin-top-left ml-5 mt-5" ]
                (List.indexedMap hexRow Board.hexGrid)
            ]
        ]
    }
