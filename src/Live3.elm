module Live exposing (main)

import Browser
import Html exposing (Html, button, div, h1, h3, img, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random


baseUrl =
    "http://elm-in-action.com/"


type Msg
    = SelectImage String
    | SurpriseMe
    | SetThumbSize ThumbnailSize
    | SelectIndex Int


type alias Model =
    { images : List { image : String }
    , selected : String
    , thumbSize : ThumbnailSize
    }


type ThumbnailSize
    = Small
    | Medium
    | Large


initialModel : Model
initialModel =
    { images =
        [ { image = "1.jpeg" }
        , { image = "2.jpeg" }
        , { image = "3.jpeg" }
        ]
    , selected = "2.jpeg"
    , thumbSize = Medium
    }


randomPhotoPicker : Random.Generator Int
randomPhotoPicker =
    Random.int 0 (List.length initialModel.images)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectImage img ->
            ( { model | selected = img }, Cmd.none )

        SurpriseMe ->
            ( { model | selected = "2.jpeg" }, Random.generate SelectIndex randomPhotoPicker )

        SetThumbSize thumbnailSize ->
            ( { model | thumbSize = thumbnailSize }, Cmd.none )

        SelectIndex i ->
            ( { model | selected = select model.selected model.images i }, Cmd.none )


select : String -> List { a | image : String } -> Int -> String
select def images i =
    let
        l =
            List.map .image images
    in
    Maybe.withDefault def (index i l)


index : Int -> List a -> Maybe a
index i l =
    case List.drop i l of
        [] ->
            Nothing

        h :: _ ->
            Just h


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , button [ onClick SurpriseMe ] [ text "Surprise Me!" ]
        , h3 [] [ text "Thumbnail Size:" ]
        , div [ id "choose-size" ] (List.map viewSizeChooser [ Small, Medium, Large ])
        , div [ id "thumbnails", class (sizeToString model.thumbSize) ] (List.map (viewThumb model) model.images)
        , img
            [ class "large"
            , src (baseUrl ++ "large/" ++ model.selected)
            ]
            []
        ]


viewSizeChooser : ThumbnailSize -> Html Msg
viewSizeChooser size =
    label []
        [ input [ type_ "radio", name "size", onClick (SetThumbSize size) ] []
        , text (sizeToString size)
        ]


sizeToString : ThumbnailSize -> String
sizeToString thumbnailSize =
    case thumbnailSize of
        Small ->
            "small"

        Medium ->
            "med"

        Large ->
            "large"


viewThumb : Model -> { b | image : String } -> Html Msg
viewThumb model thumb =
    img
        [ src (baseUrl ++ thumb.image)
        , classList [ ( "selected", model.selected == thumb.image ) ]
        , onClick (SelectImage thumb.image)
        ]
        []


main : Program () Model Msg
main =
    Browser.element
        { init = \_ -> ( initialModel, Cmd.none )
        , view = view
        , update = update
        , subscriptions = \_ -> Sub.none
        }
