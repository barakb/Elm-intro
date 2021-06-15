module Live exposing (main)

import Browser
import Html exposing (Html, div, h1, img, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)


baseUrl =
    "http://elm-in-action.com/"


type Msg
    = SelectImage String


type alias Model =
    { images : List { image : String }
    , selected : String
    }


initialModel : Model
initialModel =
    { images =
        [ { image = "1.jpeg" }
        , { image = "2.jpeg" }
        , { image = "3.jpeg" }
        ]
    , selected = "2.jpeg"
    }


update : Msg -> Model -> Model
update msg model =
    case msg of
        SelectImage img ->
            { model | selected = img }


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , div [ id "thumbnails" ] (List.map (viewThumb model) model.images)
        , img
            [ class "large"
            , src (baseUrl ++ "large/" ++ model.selected)
            ]
            []
        ]


viewThumb : Model -> { b | image : String } -> Html Msg
viewThumb model thumb =
    img
        [ src (baseUrl ++ thumb.image)
        , classList [ ( "selected", model.selected == thumb.image ) ]
        , onClick (SelectImage thumb.image)
        ]
        []


main =
    Browser.sandbox
        { init = initialModel
        , view = view
        , update = update
        }
