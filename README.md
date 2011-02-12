# Un[silent Attendant](http://magiccards.info/us/en/51.html)

A AutoIt3 program intended to help people who run free player-run tournaments on Magic Online manage all of the tasks that they need to do throughout the tournament.  It was originally built by me for making the most complex part of running these tournaments, the registration phase, a lot simpler by keeping track of all of the stats.

This program will help you by:

* Announcing before registration every 5 minutes how long there is until registration.
* Handling registration phase:
  * Parsing the chatroom looking for registrants and keeping a list
  * Announcing when a player is registered
  * Announcing the players that are registered every minute
  * Announcing in the main channel how much time is left in registration
* Announcing when a player has dropped the tournament
* Announcing how many matches are left in the round
* Announcing the pairings for each new round and the results of a round that just ended

## Requirements

In order to use this program, you need to have [AutoIt3](http://www.autoitscript.com/site/autoit/) installed.  Open the script and press F5 to start the program.  If you are on Vista or Windows 7, an Admin access window will pop up.  Unsilent Attendant needs admin access because otherwise it cannot send keystrokes to other windows.

It's also probably not of interest to you unless you have a copy of Magic the Gathering Online.

It is also not very useful unless you have a copy of DCI Reporter.  It is up to you to acquire a copy of this program, since it is not free.   Unsilent Attendant has been tested with DCI Reporter 2.9.x and I can't guatantee that it will work with version 3.x

## Setup

Unsilent Attendant assumes that you have a dual-chatroom setup for your tournaments.  In the **normal chat** window, it will announce pairings, confirm round results when the round has been completed, and do some other announcements.  In the **registration chat** window, it will check for registrations (when in registration), announce players registered, and announce any player drops.  I also use the registration chat as a results chat, so all of the results are in this window.  Matches left announcements will be made in both chats.

Configuration for the tournament is at the top of the script file, right below the large comment block.   Change the names of the chat windows and the tournament name if you like.  The tournament name can be changed again later as well.

You can also specify announcements to be made when there are a certain number of players registered, for example that the tournament will be running for more rounds to accomodate more players.  These can be set using the `$morePlayersAnnouncements` array.  Before the comma is the number of registered players that are needed, and after the comma is what will be announced.  **If you change the number of announcements in this array, remember to change the number of entries in the first line**

## Usage

Once the program has started, there are a number of buttons that will help you control it.  To get started, place your chat windows where you want them to be.   It is important to not move the tournament chat windows once their positions are set in Unsilent Attendant.  Then press the "Set Chat Pos" button, and it will prompt you to place your mouse where the chat window (normal chat, pairings, round results go here) is.  Put your mouse where you enter text in the chat window and press SPACE.  Then repeat this for the registration chat window.

When you are ready to start pre-registration, set the timer (center bottom before the large list) to how many minutes are left before registration starts for the tournament, and set the tournament name (default "SPDC 15.") to the tournament name that you want to use.  Press the "Pre" button.  It should turn green meaning that the pre-registration countdown is in effect.  When pre-registration is running, Unsilent Attendant will announce every 5 minutes how long there is until registration.  Click the "Pre" button again to turn off the pre-registration countdown.

When you are ready to start registration, set the timer to how many minutes registration should be open for, and click the "Reg" button.  The "Reg" button will turn green to indicate that registration is open, and registraton will be announced in both channels.   While registration is running, you may hit F13 on your keyboard to scan the registration window for new registrations, or tick the "Auto Check" box to automatically check every 10 seconds.  Registrations will be announced in the chat room as they happen.  When a player is registered, their name will be added to the list of registrants in alphabetical order.  You can also manually add a player to the tournament by entering their name at the bottom and pressing "Add Player".

Once registration is complete, click the "Reg" button again.  An announcement will be made that registration is closed.  

To enter the registrants into DCI-R, set the position of the DCI-R player entry window (the Last Name field) in a similar way to how you set the position of the chat windows earlier.  Then press the "Reg into DCI-R" button.  This will enter all of the players in the list into DCI-R automatically. 

While running the tournament, you can announce pairings by setting the "Round Counter" (Row 4 center, starts at 1) to whatever round you are in, copying the pairings from DCI-R, and pressing the "Paste Pairings" button.  The pairings will be announced in the normal chat, and the round start will be announced in the registration chat.

As a round is being played, you can announce how many matches are left by setting the "Match Counter" (Row 4 left) to how many matches are left, and pressing the "Ann. Matches" button. 

When a round is complete, you can announce the results of the match by copying the *Results by Table* (view menu) from DCI-R and clicking the "Paste Results" button. 

A player can be dropped at any time by clicking on their name in the list.  The drop will be announced in the registration chat.

## Author Statement

I wrote Unsilent Attendant to help me run pauper tournaments (only commons allowed) every week that I've been running for about two years on [PDCMagic](http://pdcmagic.com).  I ran SPDC using it for about two years, and created it out of a need to simplify the process. 

If you have trouble using Unsilent Attendant, feel free to email me at jamuraa@base0.net - I can answer questions or help out.

## License

Unsilent Attendant is BSD licensed.  The license is at the beginning of the unsilent-attendant.au3 file.

