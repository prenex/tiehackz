# tiehackz
Improved mouse-controls for Tie Fighter (LucasArts - 1993)

Description
===========

This is a very little assembly hack that completely exchanges
the mouse controls for LucasArts Game, TIE Fighter.

You just need to start the TIEHACKZ.COM command before running
the original TIE.exe to get a more pro-gamer friendly mouse
controls in the flight scenes of the game. The original controls
are quite slow and precise - but as you progress in the game, 
some missions will get to be unbeatable on real difficulty levels
so the original game really rely on pro players having a wingman
kind of joystick or something...

The script is the cure for this! If you play the game, the new
controls work as if there is an imaginary mouse cursor on the
screen:
* If this cursor is to the left (or right), your ship continously
  turn to the left (or right) as much as the cursor is from the
  center.
* If the cursor is to up (or down), your ship continously shrink
  (or elavate).
  
In the original controls you need to move the mouse for any moves.
Here you always move, but you control where you are moving.

This is especially helpful when you are in a dogfight and if you
would have a joystick you would just hold it back to elavate
in a loop and things like that. Now you can achieve the same effect!

For sake of sanity, my little hack only changes the mouse movements
when you are in the game!

!!! WORKS WITH DOSBOX TOO !!!

Relevant note: before you can first move in a mission, press "ESC"
to get into the in-game menu system and leave it. After this, you
can turn with the mouse! This is necessary to start the system
otherwise you will feel you are having a frozen mouse control...

PS.: I think this very same hack works with X-Wing too!

Technical details
=================

The whole thing is a clever hack in assembly. Basically what I do
is that I am saving what addresses the currently registered mouse
driver entry points/interrups point to (so that I can call them)
and I register a thin magic layer that sits between the driver and
the game!

Luckily I have found ways to distinguish calls coming from the menu
system and cut-screens from those that are from the gameplay. Using
this knowledge the hack only change in-game controls.

Actually the words about the virtual cursor are deep technical details
even though it is in the other area for end-users above. Indeed we
keep a virtual cursos in this thin layer! The further away this
cursor is from the middle point, the more fast you turn/move continously!

The function that calculates how much turn/pitch speed we get is not linear.
I tried to make it either quadratic for my intenion or something else I 
already forgot as of now, but because the layer between the driver and the
game has to be really fast and optimized, in the end this function became
a whole mess of bit-tricking and hacking that achieves some good-enough effect
while still being fast enough so that it works in my dosbox on my old laptop!

I was using my father's old turbo assembler for develoment and compiled it
as a *.COM application to keep everything as small as it can be. It is less
than 500 byte so that is a good achievement for this great enchancement ;-)
