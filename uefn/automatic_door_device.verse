using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /Fortnite.com/Characters }
using { /Fortnite.com/Playspaces }
using { /UnrealEngine.com/Temporary/SpatialMath }

doorState := enum{Open, Closed}

# A Verse-authored creative device that can be placed in a level
healer_damager_device := class(creative_device):

    @editable
    Door : creative_prop = creative_prop{}

    DistanceThreshold : float = 1000.0

    @editable
    DoorOpenZ : float = 350.0

    var Agents : []agent = array{}
    var DoorState : doorState = doorState.Closed

    @editable
    PlayerSpawner : player_spawner_device = player_spawner_device{}

    OnBegin<override>()<suspends>:void=
        PlayerSpawner.SpawnedEvent.Subscribe(PlayerSpawned)
        CheckPlayerDistanceFromDoor()

    PlayerSpawned<private>(Agent: agent): void=
        set Agents += array{Agent}

    CheckPlayerDistanceFromDoor<private>()<suspends>: void=
        loop:
            Sleep(0.1)

            if:
                Agent := Agents[0]
                Character := Agent.GetFortCharacter[]
                PlayerTransform := Character.GetTransform()
            then:
                DoorTransform := Door.GetTransform()

                DistanceFromDoor := Distance(
                    V1 := vector2{X := DoorTransform.Translation.X, Y := DoorTransform.Translation.Y},
                    V2 := vector2{X := PlayerTransform.Translation.X, Y := PlayerTransform.Translation.Y}
                )

                if (DistanceFromDoor <= DistanceThreshold):
                    OpenDoor()
                else:
                    CloseDoor()
    
    OpenDoor<private>()<suspends>: void=
        if (DoorState = doorState.Open):
            return

        MoveResult := MoveDoor(toZ := DoorOpenZ)
        
        if (MoveResult = move_to_result.DestinationReached):
            set DoorState = doorState.Open

    CloseDoor<private>()<suspends>: void=
        if (DoorState = doorState.Closed):
            return

        MoveResult := MoveDoor(toZ := 0.0)
        if (MoveResult = move_to_result.DestinationReached):
            set DoorState = doorState.Closed

    MoveDoor<private>(toZ: float)<suspends>: move_to_result=
        DoorTransform := Door.GetTransform()

        Door.MoveTo(
            vector3 {
                X := DoorTransform.Translation.X, 
                Y := DoorTransform.Translation.Y, 
                Z := toZ
            },
            DoorTransform.Rotation,
            1.0
        )
