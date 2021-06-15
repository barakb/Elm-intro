#### Elm 

* Elm is a statically typed purely functional language that compiled to JavaScript
* Elm is using the same rendering approach as React.js
* Elm’s compiler would catch a lot of the errors I’d been seeing before they could harm me in production.
* Elm code is easy to refactor and maintain
* Elm code can't throw runtime exceptions  
* Elm compiler has a reputation of user-friendliness

#### Install as node package.

#### Let's start 

###### Elm repl 

````shell
16:26 $ elm repl --no-colors
---- Elm 0.19.1 ----------------------------------------------------------------

> 1
1 : number

> 1 + 1
2 : number

````
Show 
* String 
  - string ops
* Bool
* comment
* expression  
* constants
* if, case
* function / anonymous
* function call
  - pure
  - partial evaluation  
  - let
* operators
* Indentation
* List, [], (::)
* Tuples
* Records
* Type variables


#### Elm Architecture

A model value
An update function 
update: Msg -> Model -> Model
A view function
view: Model -> Html Msg

#### creating a new project

* Declaratively rendering a page
* Managing state with Model-View-Update
* Handling user interaction

````shell
elm init

elm make src/Example.elm --output app.js

elm-live src/Example.elm -- --output app.js
````



#### First program
1. Static html
2. Adding model
3. Adding selectedUrl to model, show it with selected class, adding large view of selected image
4. * adding event `{ description = "ClickedPhoto", data = "2.jpeg" }` change selected image 
   * adding update function, onClick listener
   * move to Browser.sandbox
5. * Adding type annotations
   * Reusing type annotations with aliases
   * Adding surprise me.  (, button [] [ text "Surprise Me!" ])
   * Adding select thumb size ( , h3 [] [ text "Thumbnail Size:" ]
     , div [ id "choose-size" ] [])
     ( label []
     [ input [ type_ "radio", name "size"] []
     , text "Small"
     ])
6. * Browser.element
   * Random.generate  
   * Enumerating possibilities with custom types (ThumbnailSize)
   * Using case expression with custom types 


