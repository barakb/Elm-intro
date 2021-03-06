module Live exposing (main)

import Browser
import Html exposing (Html, button, div, h1, h3, img, input, label, text)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Random exposing (Generator)


baseUrl =
    "http://elm-in-action.com/"


type Msg
    = SelectImage String
    | SurpriseMe
    | SetThumbSize ThumbSize
    | SelectIndex Int


type alias Model =
    { images : List { image : String }
    , selected : String
    , thumbSize : ThumbSize
    }


initialModel : Model
initialModel =
    { images =
        [ { image = "1.jpeg" }
        , { image = "2.jpeg" }
        , { image = "3.jpeg" }
        ]
    , selected = "2.jpeg"
    , thumbSize = Med
    }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        SelectImage img ->
            ( { model | selected = img }, Cmd.none )

        SurpriseMe ->
            ( { model | selected = "2.jpeg" }, Random.generate SelectIndex randomInt )

        SetThumbSize size ->
            ( { model | thumbSize = size }, Cmd.none )

        SelectIndex int ->
            ( model, Cmd.none )


randomInt : Generator Int
randomInt =
    Random.int 0 (List.length initialModel.images)


type ThumbSize
    = Small
    | Med
    | Large


view : Model -> Html Msg
view model =
    div [ class "content" ]
        [ h1 [] [ text "Photo Groove" ]
        , button [ onClick SurpriseMe ] [ text "Surprise Me!" ]
        , h3 [] [ text "Thumbnail Size:" ]
        , div [ id "choose-size" ]
            (List.map viewChooseThumbSize [ Small, Med, Large ])
        , div [ id "thumbnails", class (thumbSizeToString model.thumbSize) ] (List.map (viewThumb model) model.images)
        , img
            [ class "large"
            , src (baseUrl ++ "large/" ++ model.selected)
            ]
            []
        ]


viewChooseThumbSize : ThumbSize -> Html Msg
viewChooseThumbSize size =
    label []
        [ input [ type_ "radio", name "size", onClick (SetThumbSize size) ] []
        , text (thumbSizeToString size)
        ]


thumbSizeToString : ThumbSize -> String
thumbSizeToString thumbSize =
    case thumbSize of
        Small ->
            "small"

        Med ->
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
