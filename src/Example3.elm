module Example3 exposing (main)

import Html exposing (div, h1, img, text)
import Html.Attributes exposing (..)



-- enrich model, adding class for selected image


urlPrefix =
    "http://elm-in-action.com/"


viewThumbnail selectedUrl thumb =
    img
        [ src (urlPrefix ++ thumb.url), classList [ ( "selected", selectedUrl == thumb.url ) ] ]
        []


view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ] (List.map (viewThumbnail model.selectedUrl) model.photos)
        , img [ class "large", src (urlPrefix ++ "large/" ++ model.selectedUrl) ] []
        ]


initialModel =
    { photos =
        [ { url = "1.jpeg" }
        , { url = "2.jpeg" }
        , { url = "3.jpeg" }
        ]
    , selectedUrl = "1.jpeg"
    }


main =
    view initialModel
