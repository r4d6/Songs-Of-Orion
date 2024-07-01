// This folder was written by R4d6 for 300$. I just wanted to note that down.

/* Design Document :
Nuclear Reactor that uses Eris' native Turbine + Motor setup to produce power.
Replaces the Supermatter Crystal as the main Power Source.

TL;DR : Using pipes, it draws gas in via a pipe, heats it up, and push it out via another pipe.

Has 4 Fuel Rods spot, and 5 Control Rods in an X-Formation.

locate(console) in local_area

The interface should have :
A slider/input value that goes from 0 to 100 that controls the height of the rods. It will also show the average % of the rods
A meter that shows the temperature of the core.
A meter that shows the ESTIMATED amount of power produced, based on the pressure of the exiting gas. [Source](<https://github.com/Psalms-of-Orion/Songs-Of-Orion/blob/master/code/ATMOSPHERICS/components/binary_devices/pipeturbine.dm>)
A SCRAM button, that instantly makes all the rods go down.
A button to toggle the input of gas.
A button to toggle the output of gas.
A readout for the gas in the reactor.

The height of the control rods will increase as the slider is raised.
Above 25%, it acts like naked plating, having a chance to trip running players.
Above 50%, it acts like a table, requiring players to climb on top.
Above 75%. it acts like a wall, blocking both view and movement.
If a Control Rod is missing, it is assumed to be 100% for the purpose of calculating the average.
If a Control Rod is broken, it is assumed to be at 0% for the purpose of calculating the average.

How the Reactor will work behind the scene :
The reactor will be a Multistructure (https://github.com/Psalms-of-Orion/Songs-Of-Orion/blob/master/code/game/machinery/multistructure.dm)
Every fuel rod has a heat_production value, and a consumption_rate value.
When the Reactor ticks, it will do the following :
Step 1 - Use pump_gas_passive(src, gas_input, gas_storage) to draw in gas from the input pipe. [Code](<https://github.com/Psalms-of-Orion/Songs-Of-Orion/blob/master/code/ATMOSPHERICS/_atmospherics_helpers.dm#L71>)
Step 2 - Increase the temperature of the Reactor Core by the sum of all of the current fuel rods' head_production, multiplied by the average percentage of the control rods.
Step 3 - Consume/Decrease the fuel rods' durability/lifespan by its consumption_rate value, multiplied by the average percentage of the control rods.
Step 4 - Heat up the stored gas using the Reactor Core's temperature value. (Not sure on the math needed for this)
Step 5 - Use pump_gas_passive(src, gas_storage, gas_output) to push out the heated gas through the output pipe.

If the Reactor Core's temperature, after pushing out the heated gas, is above the Melting Point of the 'shell' surrounding the control rods and fuel rods, then a meltdown will happen. [Code Reference](<https://github.com/Psalms-of-Orion/Songs-Of-Orion/blob/master/code/modules/materials/materials.dm#L110C6-L110C20>)
An alarm will sound if the Reactor Core's Temperature is at 90% of the shell's melting point or higher.


Meltdown :
Not yet decided, definitively will have lots of radiation though.
Probably would heat up the place too.
Placeholder : Big Boom.


Interactions for the Fuel & Control Rods alike (AKA how to change it) :
Step 1 : Use a big wrench to unlock/unscrew the tile's panel.
Step 2 : Use an empty hand to pull the Rod up. Pulled Control Rods will be at 100%, and pulled non-empty used Fuel Rods will emit lots of radiation.
Step 3 : Use a screwdriver to unsecure the Rod from the socket.
Step 4 : Crowbar the Rod out of the socket.
Step 5 : Place a new Rod in the socket.
Step 6 : Screwdriver the Rod in place.
Step 7 : Use an empty hand to push the Rod down.
Step 8 : Secure the panel with a big wrench.

This is how players will change a broken control rod or empty fuel rod.
Used Fuel Rods will require players to use thick temperature resistant gloves to pick up, based on the [lightbulb's check](<https://github.com/Psalms-of-Orion/Songs-Of-Orion/blob/master/code/modules/power/lighting.dm#L532>)

*/

// Here are the defines used by the nuclear reactor.
// Control Rod Height Treshold
#define HEIGHT_TRIP 25
#define HEIGHT_CLIMB 50
#define HEIGHT_WALL 75

// Steps for removing a fuel or control rod
#define STEP_INTACT 0 // Not messed with, need to unwrench the bolts
#define STEP_UNWRENCHED 1  // Unwrenched, need to pull up
#define STEP_PULLED 2 // Pulled, need to screwdriver
#define STEP_UNSECURED 3 // Unsecured, need to crowbar
#define STEP_NO_ROD 4 // Rod removed, need a new one.

