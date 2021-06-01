module Example2 exposing (main)

import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)



-- using model


urlPrefix =
    "http://elm-in-action.com/"


viewThumbnail thumb =
    img [ src (urlPrefix ++ thumb.url) ] []


view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ] (List.map viewThumbnail model)
        ]


initialModel =
    [ { url = "1.jpeg" }
    , { url = "2.jpeg" }
    , { url = "3.jpeg" }
    ]


main =
    view initialModel
