module Main exposing (..)

import AnimationFrame as Anim
import Html exposing (..)
import Html.Attributes as Attr
import Keyboard as Key
import Platform.Cmd as Cmd
import Platform.Sub as Sub
import Random exposing (..)
import Svg exposing (..)
import Svg.Attributes exposing (..)
import Time exposing (..)


-- init


type Msg
    = KeyMsg Key.KeyCode
    | Tick Float
    | RandomNum Int


type Status
    = Alive
    | Dead


type alias Model =
    { position : { x : Int, y : Int }
    , status : Status
    , score : Int
    , random : Int
    , obstacle : Bool
    , gaps : Int
    }


type alias Obstacles =
    { x : Int, y : Int, w : Int, h : Int }


init =
    ( { position = { x = 500, y = 250 }, status = Alive, score = 0, random = 0, obstacle = False, gaps = 0 }, Cmd.none )



--update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        KeyMsg keyCode ->
            if model.position.y == 460 then
                case keyCode of
                    38 ->
                        ( { model | position = { x = model.position.x, y = model.position.y - 200 }, status = Alive }, Cmd.none )

                    32 ->
                        ( { model | position = { x = model.position.x, y = model.position.y - 200 }, status = Alive }, Cmd.none )

                    39 ->
                        ( { model | position = { x = model.position.x + 30, y = model.position.y }, status = Alive }, Cmd.none )

                    37 ->
                        ( { model | position = { x = model.position.x - 30, y = model.position.y }, status = Alive }, Cmd.none )

                    _ ->
                        ( { model | status = Alive }, Cmd.none )
            else
                case keyCode of
                    39 ->
                        ( { model | position = { x = model.position.x + 30, y = model.position.y }, status = Alive }, Cmd.none )

                    37 ->
                        ( { model | position = { x = model.position.x - 30, y = model.position.y }, status = Alive }, Cmd.none )

                    _ ->
                        ( { model | status = Alive }, Cmd.none )

        Tick time ->
            if model.position.y >= 460 then
                ( { model | position = { x = model.position.x, y = 460 }, status = Alive, score = model.score + 1, gaps = model.gaps + 1 }, generate RandomNum (int 0 100) )
            else if model.status == Dead then
                ( { model | score = model.score }, Cmd.none )
            else
                ( { model | position = { x = model.position.x, y = model.position.y + 5 }, status = Alive, score = model.score + 1, gaps = model.gaps + 1 }, generate RandomNum (int 0 100) )

        RandomNum i ->
            if i == 1 then
                ( { model | random = 1, obstacle = True, gaps = 0 }, Cmd.none )
            else
                ( { model | random = i, obstacle = False }, Cmd.none )


borderStyle =
    Attr.style [ ( "border-style", "solid solid solid solid" ), ( "border-color", "blue" ) ]



-- view


view : Model -> Html.Html Msg
view model =
    let
        cposX =
            toString model.position.x

        cposY =
            toString model.position.y
    in
    div [ Attr.align "center" ]
        [ div [] [ Html.text ("Score: " ++ toString model.score) ]
        , svg [ width "1000", height "575", Attr.align "center", borderStyle ]
            [ div [] [ Html.text (toString model.score) ]
            , rect [ x "0", y "0", width "1000", height "575", fill "skyblue" ] []
            , circle [ cx cposX, cy cposY, r "50", fill "pink" ] []
            , rect [ x "0", y "500", width "1000", height "75", fill "lightgreen" ] []
            , div [] [ Html.text (toString model.score) ]
            ]
        ]



-- subscriptions


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Key.downs KeyMsg
        , Anim.times Tick
        ]



-- main


main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
