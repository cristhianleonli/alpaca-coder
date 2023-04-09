
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }

# A Verse-authored creative device that can be placed in a level
variables_device := class(creative_device):

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        # Variables
        MyInt : int = 10
        MyString : string = "Hola"
        MyFloat : float = 1.4
        MyLogic : logic = true

        # Logic, if
        Summer := false

        var WhatToDo : string = "Nothing"
        if (Summer?):
            set WhatToDo = "Swim"

        Print("I am going to {WhatToDo}")

        # Funciones basicas
        GreetPerson(name := "Alpaca")
        
        Greet2 := GreetPerson2("Alpaca")
        Print(Greet2)

        Greet3 := GreetPerson3("Alpaca", 3)
        Print(Greet3)

    # Funciones

    # Recibe un parametro y lo imprime
    GreetPerson(name: string) : void=
        Print("Hola {name}!")

    # Recibe un parametro y retorna un string
    GreetPerson2(name: string) : string=
        return "Hola {name}!"
    
    # Recibe nombre y edad y retorna un string
    GreetPerson3(name: string, age: int) : string=
        return "Hola {name}! Your age is {age}"

    # Esta function no hace nada, se usa {} para denotar vacio
    GreatFunction() : void = {}