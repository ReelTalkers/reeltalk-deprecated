import Component.Review exposing (init, update, view)
import StartApp.Simple exposing (start)
import Time exposing (second)
import Svg exposing (Svg)

main : Signal Svg.Svg
main =
    let
        show = { title = "Firefly" }
        user = { handle = "gziegan" , firstName = "Greg", lastName = "Ziegan", 
                 email = "greg.ziegan@gmail.com", phone = "012-345-6789" }
    in
        start
            { 
                model = init show 5 Time.second user,
                update = update,
                view = view
            }
