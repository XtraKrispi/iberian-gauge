module Board exposing (..)

import Dict
import Html exposing (Html)
import Html.Attributes
import Model exposing (Company, CompanyId(..), DividendLevel, Hex(..), Occupied(..), Share(..))
import SelectList
import Set
import Svg exposing (Svg)
import Svg.Attributes
import Utils


rightGreenArrow : List (Svg.Attribute msg) -> Svg msg
rightGreenArrow attrs =
    Svg.svg (Svg.Attributes.viewBox "0 0 112.32 73.982" :: attrs)
        [ Svg.g [ Svg.Attributes.transform "translate(-46.333 -64.3)" ]
            [ Svg.path [ Svg.Attributes.d "m93.327 87.584h25.844v-20.306l37.471 32.818-37.471 35.074v-22.357h-25.54c-0.30388-25.229-0.31546-26.962-0.30388-25.229z", Svg.Attributes.fill "#498762", Svg.Attributes.stroke "#fff", Svg.Attributes.strokeWidth "8" ]
                []
            ]
        ]


chart : List (Svg.Attribute msg) -> Svg msg
chart attrs =
    Svg.svg
        (Svg.Attributes.viewBox "0 0 55.325 55.14"
            :: attrs
        )
        [ Svg.g [ Svg.Attributes.transform "translate(-25.532 -46.613)" ]
            [ Svg.g []
                [ Svg.rect
                    [ Svg.Attributes.x "25.532"
                    , Svg.Attributes.y "46.613"
                    , Svg.Attributes.width "3.3793"
                    , Svg.Attributes.height "55.14"
                    , Svg.Attributes.fill "#9e6838"
                    ]
                    []
                , Svg.rect
                    [ Svg.Attributes.transform "rotate(90)"
                    , Svg.Attributes.x "98.374"
                    , Svg.Attributes.y "-80.857"
                    , Svg.Attributes.width "3.3793"
                    , Svg.Attributes.height "51.946"
                    , Svg.Attributes.fill "#9e6838"
                    ]
                    []
                , Svg.g [ Svg.Attributes.fill "#b2866c" ]
                    [ Svg.rect
                        [ Svg.Attributes.x "31.603"
                        , Svg.Attributes.y "86.268"
                        , Svg.Attributes.width "7.6783"
                        , Svg.Attributes.height "12.123"
                        , Svg.Attributes.rx "0"
                        , Svg.Attributes.ry "0"
                        ]
                        []
                    , Svg.rect
                        [ Svg.Attributes.x "44.73"
                        , Svg.Attributes.y "73.142"
                        , Svg.Attributes.width "7.6783"
                        , Svg.Attributes.height "25.25"
                        , Svg.Attributes.rx "0"
                        , Svg.Attributes.ry "0"
                        ]
                        []
                    , Svg.rect
                        [ Svg.Attributes.x "57.863"
                        , Svg.Attributes.y "60.009"
                        , Svg.Attributes.width "7.6783"
                        , Svg.Attributes.height "38.383"
                        , Svg.Attributes.rx "0"
                        , Svg.Attributes.ry "0"
                        ]
                        []
                    ]
                , Svg.rect
                    [ Svg.Attributes.x "71.788"
                    , Svg.Attributes.y "46.613"
                    , Svg.Attributes.width "7.6783"
                    , Svg.Attributes.height "51.779"
                    , Svg.Attributes.rx "0"
                    , Svg.Attributes.ry "0"
                    , Svg.Attributes.fill "#784c32"
                    ]
                    []
                ]
            ]
        ]


emptyHex : Html msg
emptyHex =
    Html.div
        [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
        , Html.Attributes.class "relative inline-block w-[96px] h-[83px] bg-transparent"
        ]
        [ Html.div
            [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
            , Html.Attributes.class "absolute top-[1px] left-[1px] w-[94px] h-[81px] bg-transparent"
            ]
            []
        ]


hex : List (Html.Attribute msg) -> Hex -> Html msg
hex attrs h =
    let
        hexWidth =
            "w-[96px]"

        innerHexWidth =
            "w-[94px]"

        innerInnerHexWidth =
            "w-[80px]"

        hexHeight =
            "h-[83px]"

        innerHexHeight =
            "h-[81px]"

        innerInnerHexHeight =
            "h-[67px]"
    in
    case h of
        Easy _ ->
            Html.div
                ([ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                 , Utils.classes
                    [ "relative"
                    , "inline-block"
                    , hexWidth
                    , hexHeight
                    , "bg-white"
                    ]
                 ]
                    ++ attrs
                )
                [ Html.div
                    [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Utils.classes
                        [ "absolute"
                        , "top-[1px]"
                        , "left-[1px]"
                        , innerHexWidth
                        , innerHexHeight
                        , "bg-[#91f2c2]"
                        ]
                    ]
                    []
                ]

        Difficult _ ->
            Html.div
                ([ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                 , Utils.classes
                    [ "relative"
                    , "inline-block"
                    , hexWidth
                    , hexHeight
                    , "bg-white"
                    ]
                 ]
                    ++ attrs
                )
                [ Html.div
                    [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Utils.classes
                        [ "absolute"
                        , "top-[1px]"
                        , "left-[1px]"
                        , innerHexWidth
                        , innerHexHeight
                        , "bg-[#91f2c2]"
                        ]
                    ]
                    [ Html.div
                        [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                        , Utils.classes
                            [ "absolute"
                            , "top-[7px]"
                            , "left-[7px]"
                            , innerInnerHexWidth
                            , innerInnerHexHeight
                            , "opacity-50"
                            , "bg-[#0a6b3b]"
                            ]
                        ]
                        []
                    ]
                ]

        Urban { name } ->
            Html.div
                ([ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                 , Utils.classes
                    [ "relative"
                    , "inline-block"
                    , hexWidth
                    , hexHeight
                    , "bg-black"
                    , "z-10"
                    ]
                 ]
                    ++ attrs
                )
                [ Html.div
                    [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Utils.classes
                        [ "absolute"
                        , "top-[1px]"
                        , "left-[1px]"
                        , innerHexWidth
                        , innerHexHeight
                        , "bg-[#567D84]"
                        , "flex"
                        , "justify-center"
                        , "items-end"
                        , "text-center"
                        ]
                    ]
                    [ Html.span
                        [ Html.Attributes.class
                            "text-white mb-3 text-[9px]"
                        ]
                        [ Html.text name ]
                    ]
                ]

        City { name } ->
            Html.div
                ([ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                 , Utils.classes
                    [ "relative"
                    , "inline-block"
                    , hexWidth
                    , hexHeight
                    , "bg-red-500"
                    , "z-10"
                    ]
                 ]
                    ++ attrs
                )
                [ Html.div
                    [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Html.Attributes.style "shape-outside" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Utils.classes
                        [ "absolute"
                        , "top-[1px]"
                        , "left-[1px]"
                        , innerHexWidth
                        , innerHexHeight
                        , "bg-[#824a4a]"
                        , "flex"
                        , "justify-center"
                        , "items-end"
                        , "text-center"
                        ]
                    ]
                    [ Html.span [ Html.Attributes.class "text-white mb-3 text-[9px]" ] [ Html.text name ] ]
                ]


dividends : List DividendLevel
dividends =
    [ { purpleYellowAmount = 3
      , blueOrangeAmount = 2
      , redAmount = 2
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 4
      , blueOrangeAmount = 3
      , redAmount = 3
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 5
      , blueOrangeAmount = 4
      , redAmount = 4
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 7
      , blueOrangeAmount = 5
      , redAmount = 5
      , hasShareBump = True
      , companies = []
      }
    , { purpleYellowAmount = 8
      , blueOrangeAmount = 6
      , redAmount = 5
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 9
      , blueOrangeAmount = 7
      , redAmount = 6
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 10
      , blueOrangeAmount = 8
      , redAmount = 7
      , hasShareBump = True
      , companies = []
      }
    , { purpleYellowAmount = 12
      , blueOrangeAmount = 9
      , redAmount = 8
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 13
      , blueOrangeAmount = 10
      , redAmount = 9
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 14
      , blueOrangeAmount = 11
      , redAmount = 10
      , hasShareBump = True
      , companies = []
      }
    , { purpleYellowAmount = 15
      , blueOrangeAmount = 12
      , redAmount = 10
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 17
      , blueOrangeAmount = 13
      , redAmount = 11
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 18
      , blueOrangeAmount = 14
      , redAmount = 12
      , hasShareBump = True
      , companies = []
      }
    , { purpleYellowAmount = 19
      , blueOrangeAmount = 15
      , redAmount = 13
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 20
      , blueOrangeAmount = 16
      , redAmount = 14
      , hasShareBump = True
      , companies = []
      }
    , { purpleYellowAmount = 22
      , blueOrangeAmount = 17
      , redAmount = 15
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 23
      , blueOrangeAmount = 18
      , redAmount = 15
      , hasShareBump = True
      , companies = []
      }
    , { purpleYellowAmount = 24
      , blueOrangeAmount = 19
      , redAmount = 16
      , hasShareBump = False
      , companies = []
      }
    , { purpleYellowAmount = 25
      , blueOrangeAmount = 20
      , redAmount = 17
      , hasShareBump = True
      , companies = []
      }
    ]


companies : List Company
companies =
    [ Company CompanyPurple 22 (SelectList.fromLists [] Unclaimed (List.repeat 3 Unclaimed))
    , Company CompanyOrange 22 (SelectList.fromLists [] Unclaimed (List.repeat 4 Unclaimed))
    , Company CompanyRed 22 (SelectList.fromLists [] Unclaimed (List.repeat 5 Unclaimed))
    , Company CompanyBlue 22 (SelectList.fromLists [] Unclaimed (List.repeat 4 Unclaimed))
    , Company CompanyYellow 22 (SelectList.fromLists [] Unclaimed (List.repeat 3 Unclaimed))
    ]


hexGrid : List (List (Occupied Hex))
hexGrid =
    [ [ Empty -- Row 1
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Urban { name = "Santander", occupied = Set.empty })
      , Occupied (Urban { name = "Bilbao", occupied = Set.empty })
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 2
      , Occupied (Urban { name = "Lugo", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Empty -- Row 3
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Rialnio", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    , [ Empty
      , Occupied (Easy { occupied = Nothing }) -- Row 4
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    , [ Empty -- Row 5
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    , [ Occupied (City { name = "Vigo", occupied = Set.empty }) -- Row 6
      , Occupied (Urban { name = "Ourense", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    , [ Empty
      , Occupied (Easy { occupied = Nothing }) -- Row 7
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Empty
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 8
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    , [ Empty
      , Occupied (Easy { occupied = Nothing }) -- Row 9
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Valladolid", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Empty
      ]
    , [ Occupied (Urban { name = "Braga", occupied = Set.empty }) -- Row 10
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (City { name = "Zaragoza", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (City { name = "Barcelona", occupied = Set.empty })
      ]
    , [ Empty
      , Occupied (Easy { occupied = Nothing }) -- Row 11
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Urban { name = "Tarragona", occupied = Set.empty })
      , Empty
      ]
    , [ Occupied (Urban { name = "Porto", occupied = Set.empty }) -- Row 12
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Segovia", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Empty
      ]
    , [ Empty
      , Occupied (Difficult { occupied = Nothing }) -- Row 13
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Empty
      , Empty
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 14
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Empty
      , Empty
      ]
    , [ Empty
      , Occupied (Easy { occupied = Nothing }) -- Row 15
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (City { name = "Madrid", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Empty
      , Empty
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 16
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Cuenca", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Empty
      , Empty
      ]
    , [ Empty
      , Occupied (Difficult { occupied = Nothing }) -- Row 17
      , Occupied (Urban { name = "Alcantera", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Castellon de la Plana", occupied = Set.empty })
      , Empty
      , Empty
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 18
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Empty
      , Empty
      ]
    , [ Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing }) -- Row 19
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Urban { name = "Caceres", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 20
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (City { name = "Valencia", occupied = Set.empty })
      ]
    , [ Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing }) -- Row 21
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 22
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Occupied (City { name = "Lisbon", occupied = Set.empty }) -- Row 23
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Urban { name = "Badajoz", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    , [ Occupied (Urban { name = "Setubal", occupied = Set.empty }) -- Row 24
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Alicante", occupied = Set.empty })
      ]
    , [ Empty -- Row 25
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 26
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Murcia", occupied = Set.empty })
      ]
    , [ Empty -- Row 27
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 28
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (City { name = "Seville", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Cartagena", occupied = Set.empty })
      ]
    , [ Empty -- Row 29
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 30
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Granada", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Empty -- Row 31
      , Occupied (Urban { name = "Villa Real de Santo Antonio", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Empty
      , Occupied (Easy { occupied = Nothing }) -- Row 32
      , Occupied (Urban { name = "Cadiz", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    ]
