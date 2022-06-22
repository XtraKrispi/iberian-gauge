module Board exposing (..)

import Html exposing (Html)
import Html.Attributes
import Model exposing (Hex(..), Occupied(..))
import Set


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
    case h of
        Easy _ ->
            Html.div
                ([ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                 , Html.Attributes.class "relative inline-block w-[96px] h-[83px] bg-white"
                 ]
                    ++ attrs
                )
                [ Html.div
                    [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Html.Attributes.class "absolute top-[1px] left-[1px] w-[94px] h-[81px] bg-[#91f2c2]"
                    ]
                    []
                ]

        Difficult _ ->
            Html.div
                ([ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                 , Html.Attributes.class "relative inline-block w-[96px] h-[83px] bg-white"
                 ]
                    ++ attrs
                )
                [ Html.div
                    [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Html.Attributes.class "absolute top-[1px] left-[1px] w-[94px] h-[81px] bg-[#91f2c2]"
                    ]
                    [ Html.div
                        [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                        , Html.Attributes.class "absolute top-[7px] left-[7px] w-[80px] h-[67px] opacity-50 bg-[#0a6b3b]"
                        ]
                        []
                    ]
                ]

        Urban { name } ->
            Html.div
                ([ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                 , Html.Attributes.class "relative inline-block w-[96px] h-[83px] bg-black z-10"
                 ]
                    ++ attrs
                )
                [ Html.div
                    [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Html.Attributes.class "absolute top-[1px] left-[1px] w-[94px] h-[81px] bg-[#567D84] flex justify-center items-end"
                    ]
                    [ Html.span [ Html.Attributes.class "text-white mb-3 text-sm" ] [ Html.text name ] ]
                ]

        City { name } ->
            Html.div
                ([ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                 , Html.Attributes.class "relative inline-block w-[96px] h-[83px] bg-red-500 z-10"
                 ]
                    ++ attrs
                )
                [ Html.div
                    [ Html.Attributes.style "clip-path" "polygon(25% 0%, 75% 0%, 100% 50%, 75% 100%, 25% 100%, 0% 50%)"
                    , Html.Attributes.class "absolute top-[1px] left-[1px] w-[94px] h-[81px] bg-[#824a4a] flex justify-center items-end"
                    ]
                    [ Html.span [ Html.Attributes.class "text-white mb-3 text-sm" ] [ Html.text name ] ]
                ]


hexGrid : List (List (Occupied Hex))
hexGrid =
    [ [ Empty -- Row 1
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
      , Occupied (Urban { name = "Town 2", occupied = Set.empty })
      ]
    , [ Occupied (Easy { occupied = Nothing }) -- Row 2
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
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
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
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
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
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
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Empty
      ]
    , [ Occupied (Urban { name = "Town 1", occupied = Set.empty }) -- Row 10
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (City { name = "City 1", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (City { name = "City 2", occupied = Set.empty })
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
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
      , Empty
      ]
    , [ Occupied (Urban { name = "Porto", occupied = Set.empty }) -- Row 12
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Town 2", occupied = Set.empty })
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
      , Occupied (City { name = "City 1", occupied = Set.empty })
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
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Empty
      , Empty
      ]
    , [ Empty
      , Occupied (Difficult { occupied = Nothing }) -- Row 17
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Town 2", occupied = Set.empty })
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
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
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
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    , [ Occupied (Urban { name = "Town 1", occupied = Set.empty }) -- Row 24
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Town 2", occupied = Set.empty })
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
      , Occupied (Urban { name = "Town 2", occupied = Set.empty })
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
      , Occupied (City { name = "City 1", occupied = Set.empty })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
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
      , Occupied (Urban { name = "Grenada", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Empty -- Row 31
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Easy { occupied = Nothing })
      ]
    , [ Empty
      , Occupied (Easy { occupied = Nothing }) -- Row 32
      , Occupied (Urban { name = "Town 1", occupied = Set.empty })
      , Occupied (Easy { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      , Occupied (Difficult { occupied = Nothing })
      ]
    ]
