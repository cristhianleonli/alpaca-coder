using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using {  /Fortnite.com/Playspaces }
using { /Fortnite.com/Characters }

# A Verse-authored creative device that can be placed in a level
healer_damager_device := class(creative_device):

    @editable
    HealManipulator : prop_manipulator_device = prop_manipulator_device{}

    @editable
    DamageManipulator : prop_manipulator_device = prop_manipulator_device{}

    # Runs when the device is started in a running game
    OnBegin<override>()<suspends>:void=
        HealManipulator.DamagedEvent.Subscribe(HealManipulatorDamaged)
        DamageManipulator.DamagedEvent.Subscribe(DamageManipulatorDamaged)

    HealManipulatorDamaged(Agent: agent) : void =
        if (FortCharacter := Agent.GetFortCharacter[]):
            FortCharacter.Heal(10.0)

    DamageManipulatorDamaged(Agent: agent) : void =
        if (FortCharacter := Agent.GetFortCharacter[]):
            FortCharacter.Damage(10.0)