module Model exposing (..)

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
    , shares : List Share
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
