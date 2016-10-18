module Compose exposing (..)

import Html exposing (Html)
import Html.App
import Widget

-- MODEL
type alias AppModel =
  { widgetModel : Widget.Model }

initialModel: AppModel
initialModel =
  { widgetModel = Widget.initialModel }

init : ( AppModel, Cmd Msg )
init =
  ( initialModel, Cmd.none )

-- MESSAGES
type Msg =
  WidgetMsg Widget.Msg

-- VIEW
view : AppModel -> Html Msg
view model =
  Html.div []
    [ Html.App.map WidgetMsg (Widget.view model.widgetModel) ]

-- UPDATE
update : Msg -> AppModel -> (AppModel, Cmd Msg)
update message model =
  case message of
    WidgetMsg subMsg ->
      let
        ( updateWidgetModel, widgetCmd ) =
          Widget.update subMsg model.widgetModel
      in
        ( { model | widgetModel = updateWidgetModel }, Cmd.map WidgetMsg widgetCmd )

-- SUBSCRIPTIONS
subscriptions : AppModel -> Sub Msg
subscriptions model =
  Sub.none

-- App
main : Program Never
main =
  Html.App.program {
    init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
  }
