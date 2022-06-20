module Board exposing (..)

import Model exposing (Hex(..))
import Svg exposing (Svg)
import Svg.Attributes


blah =
    0


hex : Hex -> Svg msg
hex h =
    let
        attrs =
            [ Svg.Attributes.points "148,183.138438763306 52,183.138438763306 4,100 52,16.8615612366939 148,16.8615612366939 196,100"
            , Svg.Attributes.stroke "black"
            , Svg.Attributes.strokeWidth "2"
            ]
    in
    Svg.svg
        [ Svg.Attributes.width "100px"
        , Svg.Attributes.viewBox "0 0 200 200"
        ]
        (case h of
            Easy _ ->
                [ Svg.polygon (Svg.Attributes.fill "#91f2c2" :: attrs) [] ]

            Difficult _ ->
                [ Svg.polygon (Svg.Attributes.fill "#91f2c2" :: attrs) []
                , Svg.polygon
                    (Svg.Attributes.class "scale-[80%] opacity-60 origin-center"
                        :: Svg.Attributes.style "transform-box: fill-box"
                        :: Svg.Attributes.fill "#0a6b3b"
                        :: attrs
                    )
                    []
                ]

            Urban { name } ->
                [ Svg.polygon (Svg.Attributes.fill "#567D84" :: attrs) []
                , Svg.text_
                    [ Svg.Attributes.class "translate-x-[50%] translate-y-[75%] text-[1.75rem] fill-white"
                    , Svg.Attributes.textAnchor "middle"
                    ]
                    [ Svg.text name ]
                ]

            City { name } ->
                [ Svg.polygon (Svg.Attributes.fill "#824a4a" :: attrs) []
                , Svg.text_
                    [ Svg.Attributes.class "translate-x-[50%] translate-y-[75%] text-[1.75rem] fill-white"
                    , Svg.Attributes.textAnchor "middle"
                    ]
                    [ Svg.text name ]
                ]
        )


bottomRight : Svg msg -> Svg msg -> Svg msg
bottomRight second first =
    Svg.g []
        [ first
        , Svg.g [ Svg.Attributes.class "translate-x-[71px] translate-y-[42px]" ] [ second ]
        ]


topRight : Svg msg -> Svg msg -> Svg msg
topRight second first =
    Svg.g []
        [ first
        , Svg.g [ Svg.Attributes.class "translate-x-[71px] translate-y-[-42px]" ] [ second ]
        ]


bottomLeft : Svg msg -> Svg msg -> Svg msg
bottomLeft second first =
    Svg.g []
        [ first
        , Svg.g [ Svg.Attributes.class "translate-x-[-71px] translate-y-[42px]" ] [ second ]
        ]


topLeft : Svg msg -> Svg msg -> Svg msg
topLeft second first =
    Svg.g []
        [ first
        , Svg.g [ Svg.Attributes.class "translate-x-[-71px] translate-y-[-42px]" ] [ second ]
        ]
