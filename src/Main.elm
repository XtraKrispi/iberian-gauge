module Main exposing (main)

import Board
import Browser
import Browser.Navigation as Nav
import Html exposing (..)
import Html.Attributes exposing (class)
import Model exposing (Company, CompanyId(..), DividendLevel, Hex(..), Occupied(..), PlayerId(..), Round, RoundProgress(..), RoundType(..), Share(..), SharePrice)
import Random
import Random.List
import SelectList exposing (Position(..), SelectList)
import Svg.Attributes
import Url
import Utils


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
    , companies : SelectList Company
    , dividends : List DividendLevel
    , sharePrices : List SharePrice
    , seed : Random.Seed
    }


init : () -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init _ url key =
    let
        ( cs, seed ) =
            Random.step (Random.List.shuffle Board.companies) (Random.initialSeed 0)
    in
    case cs of
        c :: cs_ ->
            ( { key = key
              , url = url
              , companies = SelectList.fromLists [] c cs_
              , dividends = Board.dividends
              , sharePrices = Board.sharePrices
              , seed = seed
              }
            , Cmd.none
            )

        _ ->
            -- This shouldn't happen because of the pre-seeded companies
            ( { key = key
              , url = url
              , companies = SelectList.fromLists [] (Company CompanyPurple 0 (SelectList.fromLists [] Unclaimed (List.repeat 1 Unclaimed))) []
              , dividends = Board.dividends
              , sharePrices = Board.sharePrices
              , seed = seed
              }
            , Cmd.none
            )


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


companyColor : CompanyId -> String
companyColor companyId =
    case companyId of
        CompanyBlue ->
            "bg-blue-500"

        CompanyRed ->
            "bg-red-500"

        CompanyPurple ->
            "bg-purple-500"

        CompanyOrange ->
            "bg-orange-500"

        CompanyYellow ->
            "bg-yellow-500"


playerColor : PlayerId -> String
playerColor playerId =
    case playerId of
        PlayerBlue ->
            "bg-blue-500"

        PlayerPink ->
            "bg-pink-500"

        PlayerGreen ->
            "bg-green-500"

        PlayerWhite ->
            "bg-white"

        PlayerRed ->
            "bg-red-500"


viewCompany : Bool -> Company -> Html Msg
viewCompany isSelected company =
    let
        box selected share =
            Html.div
                [ Utils.classes
                    [ "h-6"
                    , "w-6"
                    , "bg-gray-300"
                    , "flex"
                    , "items-center"
                    , "justify-center"
                    , "rounded-sm"
                    ]
                ]
                [ case share of
                    Unclaimed ->
                        Html.text ""

                    Claimed player ->
                        Html.div [ Utils.classes [ "h-5", "w-5", playerColor player ] ] []
                ]
    in
    Html.div [ Utils.classes [ companyColor company.id, "first:rounded-tl-lg", "last:rounded-bl-lg", "p-4", "flex-grow", "flex", "flex-col", "justify-between" ] ]
        (SelectList.selectedMap
            (\p item -> box (p == Selected) (SelectList.selected item))
            company.shares
        )


viewDividend : DividendLevel -> Html msg
viewDividend dividend =
    let
        colorArea amt colors =
            Html.div
                [ Utils.classes
                    [ "flex"
                    , "flex-col"
                    , "items-center"
                    ]
                ]
                [ Html.span [ Utils.classes [ "text-xl" ] ]
                    [ Html.text ("P" ++ String.fromInt amt) ]
                , Html.div [ Utils.classes [ "flex", "space-x-1" ] ]
                    (List.map (\c -> Html.div [ Utils.classes [ "w-4", "h-4", "rounded-full", "border-[1px]", companyColor c ] ] []) colors)
                ]
    in
    Html.div
        [ Utils.classes
            [ "flex-grow"
            , "flex"
            , "space-x-2"
            , "items-center"
            ]
        ]
        [ Html.div
            [ Utils.classes
                [ "border-2"
                , "w-56"
                , "p-4"
                , "h-14"
                , "rounded-lg"
                , "relative"
                ]
            , Html.Attributes.classList [ ( "bg-[#417C84]", dividend.hasShareBump ) ]
            ]
            [ if dividend.hasShareBump then
                Html.div
                    [ Utils.classes
                        [ "absolute"
                        , "right-2"
                        , "-bottom-8"
                        , "h-10"
                        , "w-10"
                        , "bg-[#D0AA82]"
                        , "border-2"
                        , "rounded-lg"
                        , "flex"
                        , "items-center"
                        , "justify-center"
                        ]
                    ]
                    [ Html.div [ Utils.classes [ "absolute" ] ]
                        [ Board.chart [ Svg.Attributes.class "w-6" ]
                        ]
                    , Html.div [ Utils.classes [ "absolute", "translate-x-[1rem]" ] ]
                        [ Board.rightGreenArrow [ Svg.Attributes.class "w-9" ] ]
                    ]

              else
                Html.text ""
            ]
        , Html.div
            [ Utils.classes
                [ "flex"
                , "space-x-4"
                , "text-white"
                ]
            ]
            [ colorArea dividend.purpleYellowAmount [ CompanyPurple, CompanyYellow ]
            , colorArea dividend.blueOrangeAmount [ CompanyBlue, CompanyOrange ]
            , colorArea dividend.redAmount [ CompanyRed ]
            ]
        ]


viewSharePrice : SharePrice -> Html msg
viewSharePrice sp =
    Html.div
        [ Utils.classes
            [ "w-14"
            , "bg-[#AFABAF]"
            , "h-32"
            , "rounded-lg"
            , "border-2"
            , "flex"
            , "flex-col"
            , "items-center"
            , "justify-end"
            , "relative"
            ]
        , Html.Attributes.classList
            [ ( "h-40 bg-[#678D8E]"
              , sp.isStartingPrice
              )
            ]
        ]
        [ Html.div
            [ Utils.classes
                [ "absolute"
                , "-bottom-8"
                , "text-white"
                ]
            ]
            [ Html.text (String.fromInt sp.price) ]
        ]


viewCosts : Html msg
viewCosts =
    Html.div [] [ Html.text "Costs" ]


viewRounds : Html msg
viewRounds =
    Html.div [] [ Html.text "Rounds" ]


view : Model -> Browser.Document Msg
view model =
    { title = "Iberian Gauge"
    , body =
        [ div
            [ Utils.classes
                [ "scale-100"
                , "flex"
                , "m-10"
                ]
            ]
          <|
            [ Html.section
                [ Utils.classes
                    [ "flex"
                    , "flex-col"
                    , "justify-evenly"
                    ]
                ]
                (SelectList.selectedMap
                    (\p item ->
                        viewCompany (p == Selected) (SelectList.selected item)
                    )
                    model.companies
                )
            , Html.div
                [ Utils.classes
                    [ "border-2"
                    , "border-black"
                    , "p-4"
                    , "flex"
                    , "bg-[#508AA3]"
                    ]
                ]
                [ Html.section
                    [ Utils.classes
                        [ "flex"
                        , "flex-col-reverse"
                        , "justify-evenly"
                        , "space-y-1"
                        ]
                    ]
                    (List.map viewDividend model.dividends)
                , Html.section
                    [ Utils.classes
                        [ "origin-top-left"
                        , "p-4"
                        , "flex"
                        , "flex-col"
                        , "items-center"
                        , "space-y-20"
                        ]
                    ]
                    [ Html.div
                        [ Utils.classes
                            [ "h-24"
                            , "bg-[#D0AA82]"
                            , "w-full"
                            , "rounded-lg"
                            , "pl-4"
                            , "flex"
                            , "items-center"
                            ]
                        ]
                        [ Html.div
                            [ Utils.classes
                                [ "flex"
                                , "space-x-3"
                                , "w-full"
                                , "justify-between"
                                ]
                            ]
                            [ Board.chart [ Svg.Attributes.class "w-16" ]
                            , Html.div
                                [ Utils.classes
                                    [ "flex"
                                    , "justify-between"
                                    , "items-center"
                                    , "w-full"
                                    ]
                                ]
                                (List.map
                                    viewSharePrice
                                    model.sharePrices
                                )
                            ]
                        ]
                    , Html.div [ Utils.classes [ "flex" ] ]
                        [ Html.div [] (List.indexedMap hexRow Board.hexGrid)
                        , Html.div [ Utils.classes [ "flex", "flex-col", "justify-between" ] ] [ Html.div [] [], Html.div [] [ viewCosts, viewRounds ] ]
                        ]
                    ]
                ]
            ]
        ]
    }
