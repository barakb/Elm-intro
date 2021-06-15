module Data.Parser exposing
    ( Parser
    , alt
    , both
    , fail
    , flatmap
    , integer
    , map
    , parse
    , regex
    , string
    , succeed
    )

import Data.Either as Either exposing (Either(..))
import Regex


type alias Parser a =
    String -> ( Either String a, String )


parse : Parser a -> String -> Either String a
parse parser input =
    let
        ( result, remains ) =
            parser input
    in
    case String.isEmpty remains of
        True ->
            result

        False ->
            Left ("remaining input: " ++ remains)


succeed : a -> Parser a
succeed a input =
    ( Either.pure a, input )


fail : String -> Parser a
fail msg input =
    ( Left ("failed: " ++ msg), input )


string : String -> Parser String
string str input =
    case String.startsWith str input of
        True ->
            ( Either.pure str, String.dropLeft (String.length str) input )

        False ->
            ( Left ("fail to parse: " ++ str), input )


regex : String -> Parser String
regex str input =
    case Regex.fromString ("^" ++ str) of
        Just re ->
            case Regex.findAtMost 1 re input of
                [ match ] ->
                    ( Either.pure match.match, String.dropLeft (String.length match.match) input )

                _ ->
                    ( Left ("fail to match: " ++ str), input )

        Nothing ->
            ( Left ("fail to parse regex: " ++ str), input )


integer : Parser Int
integer =
    let
        toInt str =
            case String.toInt str of
                Just n ->
                    succeed n

                Nothing ->
                    fail ("fail to parse integer from string " ++ str)
    in
    flatmap (regex "(\\d)+") toInt


alt : Parser a -> Parser a -> Parser a
alt a b input =
    case a input of
        ( Left _, _ ) ->
            b input

        ( Right _, _ ) as right ->
            right


both : Parser a -> Parser b -> Parser ( a, b )
both pa pb =
    map2 pa pb Tuple.pair


map : (a -> b) -> Parser a -> Parser b
map f p input =
    let
        ( res, rest ) =
            p input
    in
    ( Either.map f res, rest )


flatmap : Parser a -> (a -> Parser b) -> Parser b
flatmap p f input =
    let
        ( res, remains ) =
            p input
    in
    case res of
        Left l ->
            ( Left l, remains )

        Right r ->
            f r remains


applicative : Parser (a -> b) -> Parser a -> Parser b
applicative pf pa =
    flatmap pf <| \f -> map f pa


map2 : Parser a -> Parser b -> (a -> b -> c) -> Parser c
map2 pa pb f =
    applicative (map f pa) pb
