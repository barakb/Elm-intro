module Data.Either exposing (Either(..), applicative, flatmap, getOrElse, map, pure)


type Either l r
    = Left l
    | Right r


map : (a -> b) -> Either l a -> Either l b
map f e =
    case e of
        Left l ->
            Left l

        Right r ->
            Right (f r)


pure : v -> Either l v
pure =
    Right


applicative : Either l (a -> b) -> Either l a -> Either l b
applicative f aa =
    case f of
        Left l ->
            Left l

        Right r ->
            map r aa


getOrElse : Either l r -> r -> r
getOrElse either default =
    case either of
        Left l ->
            default

        Right r ->
            r


flatmap : Either l a -> (a -> Either l b) -> Either l b
flatmap e f =
    case e of
        Left l ->
            Left l

        Right r ->
            f r
