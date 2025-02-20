# assembly breakout clone .•°

play a classic breakout-style game with a friend - or by yourself, it's still fun!!

<p align="center">
  <img width="453" alt="image" src="https://github.com/mayumon/assembly-breakout-clone/assets/113377248/65c8aabb-5c68-4a47-a544-6708a9fb6a53">
  </p>

the goal of the game is to use the paddles to bounce a ball against a wall of bricks while preventing the ball from falling below the paddle. 

you have three lives, so you can drop the ball a couple of times before you lose.

this was a simple but long project with collision detection, bright graphics, and MIDI sounds I made to learn more about MIPS.

## $\textcolor{#B6B2FF}{✩ \ setup}$

open the game file on MARS MIPS simulator.

---

#### $\textcolor{#E1DCFF}{✦ \ display}$

open the Bitmap Display window from the "Tools" menu.

connect it to MIPS then configure it with the following values:

  * Unit width in pixels: 8
  * Unit height in pixels: 8
  * Display width in pixels: 256
  * Display height in pixels: 256
  * Base Address for Display: 0x10008000 ($gp)

you will see the game through this window.

---

#### $\textcolor{#E1DCFF}{✦ \ keyboard}$

open the Keyboard and Display MMIO Simulator from the "Tools".

connect it to MIPS.

you will write your inputs on the lower text box.

---

#### $\textcolor{#E1DCFF}{✦ \ assemble \ and \ play!}$

press F3/Assemble to assemble the game file.

when you are ready to play, press the Run/Go button.

<br/><br/>

## $\textcolor{#B6B2FF}{✩ \ controls}$

pause - P

reset - R

??? - H

---

#### $\textcolor{#E1DCFF}{✦ \ bottom \ paddle }$
move left - A

move right - D

---

#### $\textcolor{#E1DCFF}{✦ \ top \ paddle }$
move left - J

move left - L

<br/><br/>

## $\textcolor{#B6B2FF}{✩ \ help }$ 

if the movement of the ball is abnormally fast/slow, read and modify lines 243-246 of the game file.

if the game seems unresponsive, assemble and run the file again. ensure keyboard simulator and bitmap display are connected to MIPS.

for any other issues, reach out.
