module Data.Maybe exposing (..)


type Maybe a
    = Just a
    | Nothing


map : (a -> b) -> Maybe a -> Maybe b
map f maybe =
    case maybe of
        Just a ->
            Just <| f a

        Nothing ->
            Nothing



{--
    examples
> import Data.Maybe exposing (..)
> Data.Maybe.pure
<function> : a -> Maybe a
> (+)
<function> : number -> number -> number
> map (+) (pure 3)
Just <function> : Maybe (number -> number)
> mf = map (+) (pure 3)
Just <function> : Maybe (number -> number)
> applicative mf (pure 4)
Just 7 : Maybe number
--}


pure : a -> Maybe a
pure =
    Just


applicative : Maybe (a -> b) -> Maybe a -> Maybe b
applicative mf ma =
    case mf of
        Just f ->
            map f ma

        Nothing ->
            Nothing


flatmap : Maybe a -> (a -> Maybe b) -> Maybe b
flatmap ma f =
    case ma of
        Just a ->
            f a

        Nothing ->
            Nothing
