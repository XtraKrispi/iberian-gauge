module Model exposing (..)

import Dict exposing (Dict)
import SelectList exposing (SelectList)
import Set exposing (Set)


type RoundType
    = StockRound
    | BuildRound


type RoundProgress
    = InProgress
    | NotReached


type alias Round =
    { roundType : RoundType
    , progress : RoundProgress
    }


type CompanyId
    = CompanyRed
    | CompanyPurple
    | CompanyOrange
    | CompanyBlue
    | CompanyYellow


type PlayerId
    = PlayerPink
    | PlayerGreen
    | PlayerBlue
    | PlayerWhite
    | PlayerRed


type Share
    = Unclaimed
    | Claimed PlayerId


type alias Company =
    { id : CompanyId
    , trains : Int
    , shares : SelectList Share
    }


type Hex
    = Easy { occupied : Maybe CompanyId }
    | Difficult { occupied : Maybe CompanyId }
    | Urban { name : String, occupied : Set CompanyId }
    | City { name : String, occupied : Set CompanyId }


type alias Coord =
    { x : Int, y : Int }


type Occupied a
    = Occupied a
    | Empty


type alias DividendLevel =
    { purpleYellowAmount : Int
    , blueOrangeAmount : Int
    , redAmount : Int
    , hasShareBump : Bool
    , companies : List CompanyId
    }


type alias SharePrice =
    { price : Int
    , companies : List CompanyId
    , isStartingPrice : Bool
    }
