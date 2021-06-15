module ParserTests exposing (..)

import Data.Either exposing (Either(..))
import Data.Parser exposing (alt, both, integer, parse, string, succeed)
import Expect exposing (Expectation, pass)
import Test exposing (..)


suite : Test
suite =
    describe "Primitives"
        [ test "succeed" <|
            \_ ->
                parse (succeed 5) ""
                    |> succeedWithValue 5
                    |> Expect.equal True
        , test "integer" <|
            \_ ->
                parse integer "33"
                    |> succeedWithValue 33
                    |> Expect.equal True
        , test "alt take first" <|
            \_ ->
                parse (alt (string "33") (string "31")) "33"
                    |> succeedWithValue "33"
                    |> Expect.equal True
        , test "alt take second" <|
            \_ ->
                parse (alt (string "31") (string "33")) "33"
                    |> succeedWithValue "33"
                    |> Expect.equal True
        , test "alt fail" <|
            \_ ->
                parse (alt (string "31") (string "31")) "33"
                    |> succeedWithValue "33"
                    |> Expect.equal False
        , test "both" <|
            \_ ->
                parse (both (string "33") integer) "3333"
                    |> succeedWithValue ( "33", 33 )
                    |> Expect.equal True
        ]


succeedWithValue : v -> Either String v -> Bool
succeedWithValue v p =
    case p of
        Left _ ->
            False

        Right r ->
            r == v
