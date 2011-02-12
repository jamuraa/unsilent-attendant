; We need admin on Vista / Windows 7 because otherwise we can't interact with other windows
#RequireAdmin

#CS
Unsilent Attendant

Copyright 2009-2011 Michael Janssen. All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are
permitted provided that the following conditions are met:

   1. Redistributions of source code must retain the above copyright notice, this list of
      conditions and the following disclaimer.

   2. Redistributions in binary form must reproduce the above copyright notice, this list
      of conditions and the following disclaimer in the documentation and/or other materials
      provided with the distribution.

THIS SOFTWARE IS PROVIDED BY MICHAEL JANSSEN ``AS IS'' AND ANY EXPRESS OR IMPLIED
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL <COPYRIGHT HOLDER> OR
CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

The views and conclusions contained in the software and documentation are those of the
authors and should not be interpreted as representing official policies, either expressed
or implied, of Michael Janssen.

INSTRUCTIONS:

With MTGO launched, run the script.

** The buttons are, from left to right and top to bottom:
 - Set Chat position: Use this to set the position of the two chat windows (normal and tourney)
 - Set DCI-R postion: Use this to set the location fo the TOP player box in the Player Entry window of DCI-R
 - Paste pairings: Paste from DCI-R (copy them first!) pairings into the chat channel.
 - The countdown window! This box counts down to the next registration announcement.
 - Enter Into DCI-R. If the DCI-R position is set, this will enter all of the registered players into DCI-R
 - Paste Results: Paste from DCI-R (copy them first!) results (by table) into the chat channel.
 - Start/Stop Pre-Registration.  This starts and stops the pre-registration!
 - Start/Stop Registration.  This Starts and stops the registration!
 - Auto Chk - If this is checked, the registration channel will be checked every 10 seconds for new registrants.
 - Tourney NAME - this is the name which is used in some announcements.
 - Matches Counter - This is the matches left counter.  Set it to the number of matches left in the current round.
 - Round Counter - This is the round number counter.  Set it to the round number.
 - Ann Matches - This will announce how many matches are left in the round to both the chat and registration channels.
 - Random player - picks a random player who is still left in the tournament.  Useful for door prizes.

** GLOBAL KEY CODES:
 - F13: Check the registration room for registrations.
 - F14: Copy the list of players to your clipboard (comma separated)

TODO LIST (ideas list):
 - Make the copy/paste code a litle bit better, since it sometimes fucks up
 - Activate the windows with windows calls instead of a click, wait, click sequence.
 - In the same vein, switch back to the window that was active before an announcement was made.
 - Only process the registrations that haven't been processed yet (hash and match?)
 - Automatically start the registration at the end of the pre-reg period
 - Use the actual clock to tell how many minutes are left in the pre-reg and reg instead of timers we have now
 - Put all of the configuration stuff on a separate window
 - Save the players in the tourney + window locations, etc. to a config file so if we crash we can start up again
 - Use log files to scan for registrations instead of using the windows.  (No good - log files are not updated until window is closed)
 - Register the players to gatherling using HTTP calls
 - Invert the colors of the Pre-reg, reg boxes when the pre-reg or registration is running
 - "Quick Click" chat window - for automatically chatting things like

Revision History (Date, Initials, Description)
2009-06-18 - MDJ Added support for pasting into the chat window the Matches and the Results.
           - Copy them into the clipboard first, and make sure the chat position is set on the window you want to paste into.
2009-08-06 - Added support for on-demand scanning.  Hit F13 to scan the chat window for registrations.
		   - Removed automated scanning so that you have more of a chance to chat between ads.
		   - Added counter for Ad, when it hits zero it will do the Ad
		   - Added support to set up DCI-R.  Make sure to set the DCI-R point first.
2009-08-20 - Added ability to drop players by clicking on their names in the list
           - Consolidated "Start Registration" and "Stop Registration" into one button which changes modes based on whether reg is running
		   - Added count of players to the advertisement
		   - Added RED warning color to the countdown when there is < 10 seconds.
2009-09-03 - Added support for auto-polling of channel.  Click the checkbox to poll every 10 seconds.
2010-01-22 - Added support for two channels in normal operation.
           - Added support to announce matches left in both channels
	       - Bump default value to SPDC 11.xx
		   - Added some text at the end of Pairings and Results announcements.
2010-01-28 - Added more text to the paste results and pairings based on the round clicker
		   - Switched all text to the right windows, you can coordinate the windows once.
		   - Added some more documentation at the top.
2010-02-02 - Made the round clicker automatically tick up after posting results
2010-03-25 - Sped up Channel text.
		   - Added "normal" channel spammage every 5 minutes.
2010-04-01 - Fixed the ability to drop players by clicking, and announce when players are dropped
           - Refactor some of the code to make it cleaner
		   - You can now manually add players on the bottom
		   - Mouse speed is SUPER fast now when it doesn't break
2010-04-08 - Player name is cleared after an add
           - Reg sensing mouse doesn't double-click anymore and open PM boxes
		   - Remove a ton of variables that we aren't using (leftover from bot)
		   - Make chat pos variables arrays to reduce var count
		   - Make DCI-R entering faster
2010-04-22 - Addded "Paste slowly" for pasting rules at the start of tourneys.
2010-05-?? - Tweaks to the timing so that the paste buffer isn't messed up.
2010-06-10 - Alphabetize names (case insensitive) in the player list to make it easier to find them
           - Add randomly pick a player from remaining (for door prizes, etc)
		   - Count down minutes left in registration (new counter on GUI)
		   - Automatically announce when registration is over
2010-07-08 - Increased the time for the pasting, because sometimes it wasn't waiting long enough
             for windows to update the clipboard.
           - Added the ability to copy the list of players registered to your clipboard with F14
		   - Number of matches left will round down now
2010-07-15 - Added pre-reg countdown, every 5 minutes before the reg starts it will announce that reg is coming up.
2010-12-02 - Keep track of how many players there are - announce when there will be more rounds and/or more top 8
           - (use the morePlayersAnnouncements array.)
2011-02-12 - Refined GUI.  Made it a bit smaller and buttons are more gridded out now.
           - Red and Green button colors for Registration / Pre-Registration running.
		   - Check that the positions are set before actually doing things.
		   - Other minor code changes.
		   - Bump version to v1.  First public release.
#CE

;;;; CONFIGURATION VARIABLES FOR TOURNAMENT CUSTOMIZATION ;;;;
; Announcement threshholds and announcements.
Dim $morePlayersAnnouncements[3]
$morePlayersAnnouncements[0] = "18,[sSET ALA R] WE NOW HAVE 18 REGISTERED PLAYERS AND WILL PLAY **TOP 8 FINALS** [sSET ALA R]"
$morePlayersAnnouncements[1] = "24,[sSET ALA R] WE NOW HAVE 24 REGISTERED PLAYERS AND WILL PLAY **4 ROUNDS OF SWISS** AND **TOP 8 FINALS** [sSET ALA R]"
$morePlayersAnnouncements[2] = "40,[sSET ALA R] WE NOW HAVE 40 REGISTERED PLAYERS AND WILL PLAY **5 ROUNDS OF SWISS** AND **TOP 8 FINALS** [sSET ALA R]"

; Channel names, used in announcements
$comChannelName = "spdccom"
$normalChannelName = "pdc"

$defaultTourneyName = "SPDC 15."

;;;; CONFIG ENDS HERE ;;;;

#include <GUIConstantsEx.au3>
#include <Array.au3>
#include <WindowsConstants.au3>
#include <ListboxConstants.au3>
#include <ScreenCapture.au3>
#include <File.au3>
#include <WinAPI.au3>
#include <GDIPlus.au3>
#include <Misc.au3>

$dll = DllOpen("user32.dll")

Dim $guimsg
Dim $RegisteredPlayerArray[999]
Dim $registeredplayers ;  valid entries in RegisteredPlayerArray
Dim $NewRegisteredPlayerArray[99]
Dim $newregisteredplayers ; new registrants since the last time we announced.
Dim $registeredplayersannounced ; set to 1 when we want to announce a registration
Dim $maxRegisteredPlayers ; the maximum number of players to be announced yet.

; Positions on the screen
Dim $chatpos[2]
$chatpos[0] = -1
$chatpos[1] = -1
Dim $comchatpos[2]
$comchatpos[0] = -1
$comchatpos[1] = -1
Dim $dcirpos[2]
$dcirpos[0] = -1
$dcirpos[1] = -1

Dim $comChannelName
Dim $normalChannelName
Dim $manualAddPlayer
Dim $preRegTimer


$maxtime = 600000
$registeredplayers = 0
$maxRegisteredPlayers = 0
$lastregisterednotice = -1


$notRunningColor = 0xff1111
$runningColor = 0x11ff11

Global $regRunning = False
Global $preRegRunning = False

ShowMainWindow()
GuiWait()

Func ShowMainWindow()

	$guiwidth = 270
	$guiheight = 700
	$cellSpacing = 5
	$margins = 10

	$rowheight = 20
	$rowTopOffset = $rowheight + $cellSpacing

	$oneThirdWidth = ($guiwidth - ($cellSpacing * 2) - ($margins * 2)) / 3
	$halfThirdWidth = ($oneThirdWidth - $cellSpacing) / 2
	Dim $columnLeft[3]
	$columnLeft[0] = $margins
	$columnLeft[1] = $columnLeft[0] + $oneThirdWidth + $cellSpacing
	$columnLeft[2] = $columnLeft[1] + $oneThirdWidth + $cellSpacing

	Global $gui = GUICreate ( "Unsilent Attendant v1 - by Michael Janssen", $guiwidth, $guiheight, @DesktopWidth-$guiwidth, 0)

	$row = 0
	Global $getchatposbtn = GUICtrlCreateButton( "Set Chat Pos" , $columnLeft[0], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	Global $getdcirposbtn = GUICtrlCreateButton( "Set DCIR Pos" , $columnLeft[1], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	Global $chatPairingsBtn = GUICtrlCreateButton( "Paste Pairings",  $columnLeft[2], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)

	$row = 1
	Global $timeleftannedit = GUICtrlCreateInput( "None", $columnLeft[0], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	Global $dcirenterbtn = GUICtrlCreateButton( "Reg into DCIR", $columnLeft[1], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	Global $chatResultsBtn = GUICtrlCreateButton( "Paste Results", $columnLeft[2], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)

	$row = 2
	Global $preRegButton = GUICtrlCreateButton ( "Pre", $columnLeft[0], $margins + ($row * $rowTopOffset), $halfThirdWidth, $rowheight)
	Global $registBtn = GUICtrlCreateButton ( "Reg", $columnLeft[0] + $cellSpacing + $halfThirdWidth, $margins + ($row * $rowTopOffset), $halfThirdWidth, $rowheight)

	Global $autoRunRegBtn = GUICtrlCreateCheckbox( "Auto Reg", $columnLeft[1], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	Global $tourneynameEdit = GuiCtrlCreateInput( $defaultTourneyName, $columnLeft[2], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)

	GUICtrlSetBkColor( $preRegButton, $notRunningColor )
	GUICtrlSetBkColor( $registBtn, $notRunningColor )

	$row = 3
	Global $matchesLeftClicker = GUICtrlCreateInput( "10", $columnLeft[0], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	GUICtrlCreateUpdown($matchesLeftClicker)
	Global $roundLeftClicker = GUICtrlCreateInput( "1", $columnLeft[1], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	GUICtrlCreateUpdown($roundLeftClicker)
	Global $roundLeftBtn = GUICtrlCreateButton( "Ann. Matches", $columnLeft[2], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)

	$row = 4
	Global $pasteSlowlyBtn = GUICtrlCreateButton("Paste to chat", $columnLeft[0], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	Global $regMinsLeftClicker = GUICtrlCreateInput( "30", $columnLeft[1], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)
	GUICtrlCreateUpdown($regMinsLeftClicker)
	Global $randomPlayerBtn = GUICtrlCreateButton("Random Player", $columnLeft[2], $margins + ($row * $rowTopOffset), $oneThirdWidth, $rowheight)

	$row = 5
	Global $regGUIlist = GUICtrlCreateList("", $columnLeft[0], $margins + ($row * $rowTopOffset), $guiwidth - ($margins * 2), $guiheight - $margins - ($row * $rowTopOffset) - ($rowheight + $cellSpacing) - $cellSpacing, $LBS_NOSEL + $WS_VSCROLL + $WS_BORDER)

	$row = 9999
	; Spans 2 columns
	Global $manualAddPlayer = GUICtrlCreateInput( "", $columnLeft[0], $guiheight - ($rowheight + $margins), ($oneThirdWidth * 2) + $cellSpacing, $rowheight)
	Global $manualAddPlayerBtn = GUICtrlCreateButton("Add Player", $columnLeft[2], $guiheight - ($rowheight + $margins), $oneThirdWidth, $rowheight)
	GUISetState ()
EndFunc

Func GuiWait() ;Wait for user to select something.
While 1
	$guimsg = GUIGetMsg()
	Select
	Case $guimsg = $getchatposbtn
		getChatPos()
	Case $guimsg = $getdcirposbtn
		getDciPos()
	Case $guimsg = $dcirenterbtn
		If $dcirpos[0] = -1 Then
			MsgBox( 0x10, "Position missing", "Please set the DCI-R registrant field position")
		Else
			enterRegistrantsToDciR()
		EndIf
	Case $guimsg = $chatPairingsBtn
		chatPairingsFromClipboard()
	Case $guimsg = $chatResultsBtn
		chatResultsFromClipboard()
	Case $guimsg = $pasteSlowlyBtn
		chatFromClipboardSlowly()
	Case $guimsg = $roundLeftBtn
		chatMatchesLeft()
	Case $guimsg = $registBtn
		If $chatpos[0] = -1 Then
			MsgBox( 0x10, "Position missing", "Please set the chat positions before starting registration")
		Else
			$tourneyName = GUICtrlRead($tourneynameEdit)
			channelText($tourneyName & " Registration is NOW open!  Register by typing 'reg' in /join " & $comChannelName)
			comChannelText($tourneyName & " Registration is NOW open!  Register by typing 'reg' in this channel!")
			$regRunning = True
			runRegistration()
			comChannelText("[sSET ROE R] Registration is NOW CLOSED for " & $tourneyName & " - Any more registrations are at the discretion of the organizer (that's me).[sSET ROE R]")
			channelText("[sSET ROE R] Registration is NOW CLOSED for " & $tourneyName & " - Any more registrations are at the discretion of the organizer (that's me).[sSET ROE R]")
			$regRunning = False
		EndIf
	Case $guimsg = $randomPlayerBtn
		RandomlyPickPlayer()
	Case $guimsg = $preRegButton
		If $chatpos[0] = -1 Then
			MsgBox( 0x10, "Position missing", "Please set the chat positions before starting registration")
		Else
			If $preRegRunning Then
				$preRegRunning = False
				GUICtrlSetBkColor( $preRegButton, $notRunningColor )
			Else
				$preRegRunning = True
				GUICtrlSetBkColor( $preRegButton, $runningColor )
				$preRegTimer = TimerInit() - 60000
			EndIf
		EndIf
	Case _IsPressed("7D", $dll) ; F14
		ClipPutPlayerList()
	Case Else
		GuiAlwaysOnCheck($guimsg)
	EndSelect
	sleep(20)
WEnd
EndFunc

Func Close() ;close gui and terminate script
Exit
EndFunc

Func GuiAlwaysOnCheck($guimsg = False)
	If not $guimsg Then
		$guimsg = GUIGetMsg()
	EndIf
	Select
	Case $guimsg = $manualAddPlayerBtn
		$newplayer = GUICtrlRead($manualAddPlayer)
		If $newplayer <> "" Then
			addRegistrant($newplayer)
			comChannelText("Host added registrant: " & $newplayer)
			GUICtrlSetData($manualAddPlayer, "")
		EndIf
	Case $guimsg = $regGUIlist
		unregisterClickedPlayerList()
	Case $guimsg = -3
		Close()
	EndSelect
	If $preRegRunning And TimerDiff($preRegTimer) > 60000 Then ; 1 minute
		$minsLeft = GuiCtrlRead($regMinsLeftClicker)
		$minsLeft = $minsLeft - 1
		if Mod($minsLeft, 5) == 0 Then
			$tourneyName = GUICtrlRead($tourneynameEdit)
			channelText("Registration for " & $tourneyName & " is in " & $minsLeft & " minutes! Stay tuned!");
		EndIf
		GUICtrlSetData($regMinsLeftClicker, $minsLeft)
		$preRegTimer = TimerInit()
	EndIf
	Return
EndFunc

; Type something into a channel box at position x, y
Func chatAtChannel($saythis, $chatx, $chaty)
	$prevmousepos = MouseGetPos()
	$prevclip = ClipGet()
	; Type the text into the channel at the default opening location.
	MouseClick("left", $chatx, $chaty, 1, 0)
	sleep(20)
	MouseClick("left", $chatx, $chaty, 1, 0)
	sleep(200)
	ClipPut($saythis)
	sleep(400)
	Send("^v{ENTER}")
	ClipPut($prevclip)
	MouseMove($prevmousepos[0], $prevmousepos[1], 0)
EndFunc

Func channelText($saythis) ;Type something into the main channel
	chatAtChannel($saythis, $chatpos[0], $chatpos[1])
EndFunc

Func comChannelText($saythis) ;Type something into the registration / results channel
	chatAtChannel($saythis, $comchatpos[0], $comchatpos[1])
EndFunc

Func waitForSpaceBarPos() ;  Waits for a spacebar hit, and returns the location of the mouse.
	While 1
		If _IsPressed("20", $dll) Then
			Return MouseGetPos()
		EndIf
		Sleep(20) ; Don't take up all CPU
	WEnd
EndFunc

Func getChatPos() ; Query the user for the chat window positions
	MsgBox(262144, "Get Chat Position", "Move the mouse to the position that the chat window is, and hit the SPACEBAR");
	$chatpos = waitForSpaceBarPos()
	MsgBox(262144, "Chat Position Set", "Chat Position Set to " & $chatpos[0] & ", " & $chatpos[1]);
	MsgBox(262144, "Get Com Chat Position", "Move the mouse to the position that the registration chat window is, and hit the SPACEBAR");
	$comchatpos = waitForSpaceBarPos()
	MsgBox(262144, "Tourney Chat Position Set", "Tourney Chat Position Set to " & $comchatpos[0] & ", " & $comchatpos[1]);
EndFunc

Func getDciPos() ; Query the user for the DCI-R Registration positions
	MsgBox(262144, "Get DCI-R Position", "Move the mouse to the position that the DCI-R player entry is, and hit the SPACEBAR");
	$dcirpos = waitForSpaceBarPos()
	MsgBox(262144, "DCI-R Position Set", "DCI-R Position Set to " & $dcirpos[0] & ", " & $dcirpos[1]);
EndFunc

Func enterRegistrantsToDciR() ; Enter the registrants into the DCI-R
	For $i = 0 to ($registeredplayers - 1)
		MouseClick("left", $dcirpos[0], $dcirpos[1], 1, 0)
		Sleep(50)
		Send("x{TAB}")
		Sleep(50)
		Send($RegisteredPlayerArray[$i], 1)
		Sleep(50)
		Send("{ENTER}")
		Sleep(50)
	Next
EndFunc

Func runRegistration() ; Start the tournament!
	GuiCtrlSetBkColor( $registBtn, $runningColor )
	$startTime = TimerInit() - 60000
	$checkTime = TimerInit() - 10000
	$chatSpamTime = TimerInit() - 300000
	$backisred = False
	while 1
		$secondsBeforeAd = 60 - Int(TimerDiff($startTime) / 1000)
		GUICtrlSetData( $timeleftannedit, String($secondsBeforeAd))
		if ($secondsBeforeAd <= 10 And not $backisred) Then
			GUICtrlSetBkColor( $timeleftannedit, 0xff0000)
			$backisred = true
		ElseIf ($backisred and $secondsBeforeAd > 10) Then
			GUICtrlSetBkColor( $timeleftannedit, 0xffffff)
			$backisred = false
		EndIf
		 ; run an ad in the CHAT channel every 5 minutes
		if TimerDiff($chatSpamTime) > 300000 then
			$tourneyName = GUICtrlRead($tourneynameEdit)
			$minsLeft = GUICtrlRead($regMinsLeftClicker)
			channelText($tourneyName & " Registration is OPEN for " & $minsLeft & " more minutes! To register, type REG in /join " & $comChannelName)
			$chatSpamTime = TimerInit()
		EndIf
		 ; run an ad in COM if it's been idle more than 60 seconds
		if TimerDiff($startTime) > 60000 then
			$minsLeft = GUICtrlRead($regMinsLeftClicker)
			$minsLeft -= 1
			comChannelText($minsLeft & " minutes left in registration - To register, type REG in this channel")
			GUICtrlSetData($regMinsLeftClicker, $minsLeft)
			If $registeredplayers > 0 Then
				$registeredNow = $registeredplayers & " Currently Registered: "
				For $i = 0 to ($registeredplayers - 1)
					$registeredNow = $registeredNow & $RegisteredPlayerArray[$i] & " "
				Next
				comChannelText($registeredNow)
			EndIf
			$startTime = TimerInit() ; reset the timer
		endif
		If _IsPressed("1B", $dll) Then ; Pressing escape stops registration
			Return
		EndIf
		$timeCheckNow = (TimerDiff($checkTime) > 10000) and (GUICtrlRead($autoRunRegBtn) = $GUI_CHECKED)
		If _IsPressed("7C", $dll) or $timeCheckNow Then ; Pressing F13 = scan players
			processNewRegistrants()
			$checkTime = TimerInit()
		EndIf
		$guimsg = GUIGetMsg()
		Select
		Case $guimsg = $registBtn
			GuiCtrlSetBkColor( $registBtn, $notRunningColor )
			Return
		Case Else
			GuiAlwaysOnCheck($guimsg)
		EndSelect
		Sleep(50)
	WEnd
EndFunc

Func processNewRegistrants() ; Process the New registrants in the channel
	$newlines = getAllLines()
	For $linenum = 0 to 6
		$matches = StringRegExp( $newlines[$linenum] , "\[b\](.+)\[\/b\]: *[Rr][Ee][Gg]", 1)
		If @error = 0 Then
			addRegistrant($matches[0])
		ElseIf @error = 2 Then
			MsgBox(0, "Debug", "Regexp Error at char " & String(@extended))
		EndIf
	Next
	if $registeredplayersannounced <> $registeredplayers Then
		if $newregisteredplayers > 0 Then
			Local $registeredList
			$registeredList = String($registeredplayers) & " Players Registered - just added " & $NewRegisteredPlayerArray[0] ; Always at least one here now
			For $i = 2 to $newregisteredplayers
				$registeredList = $registeredList & ", " & $NewRegisteredPlayerArray[($i - 1)]
			Next
			$newregisteredplayers = 0
		ElseIf $registeredplayers > 0 Then
			$registeredList = String($registeredplayers) & " Players Registered! " & $RegisteredPlayerArray[$registeredplayers - 1] & " was the last to register."
		Else
			$registeredList = "No players registered! Be the first to register!"
		EndIf
		comChannelText($registeredList)
		$registeredplayersannounced = $registeredplayers
	EndIf
EndFunc

; player clicked on for droppage in list.
Func unregisterClickedPlayerList()
	; Unregister the player that was clicked on
	$playerGone = GUICtrlRead($regGUIlist)
	If delRegistrant($playerGone) Then
		If $regRunning Then
			comChannelText("Host has dropped " & $playerGone & " from the tournament.  Please type 'reg' again if you change your mind, " & $playerGone & "!")
		Else
			$tourneyName = GUICtrlRead($tourneynameEdit)
			comChannelText("Host has dropped " & $playerGone & " from the tournament. Thanks for playing "& $tourneyName & "!")
		EndIf
	EndIf
EndFunc

Func refreshPlayerListCtrl()
	$RegisteredPlayerArray = ArraySortInsensitive($RegisteredPlayerArray, $registeredplayers)
	$regListString = "|"
	For $i = 0 to ($registeredplayers - 1)
		$regListString = $regListString & $RegisteredPlayerArray[$i] & "|"
	Next
	GUICtrlSetData( $regGUIlist, $regListString )
EndFunc

Func isRegistered($player)
	For $i = 0 to ($registeredplayers - 1)
		If StringCompare($player, $RegisteredPlayerArray[$i]) = 0 Then
			return $i
			ExitLoop
		EndIf
	Next
	return -1
EndFunc

Func addRegistrant($newRegistrant)
	; Check to see if they are in the registrants already
	if isRegistered($newRegistrant) == -1 Then
		$RegisteredPlayerArray[$registeredplayers] = $newRegistrant
		$NewRegisteredPlayerArray[$newregisteredplayers] = $newRegistrant
		$registeredplayers += 1
		$newregisteredplayers += 1
		refreshPlayerListCtrl()
	EndIf
	if $maxRegisteredPlayers < $registeredplayers Then
		morePlayersAnnouncements($registeredplayers)
		$maxRegisteredPlayers = $registeredplayers
	EndIf
EndFunc

Func delRegistrant($oldRegistrant)
	$regplace = isRegistered($oldregistrant)
	If $regplace <> -1 Then
		For $i = $regplace to ($registeredplayers - 2)
			$RegisteredPlayerArray[$i] = $RegisteredPlayerArray[$i + 1]
		Next
		$registeredplayers -= 1
		refreshPlayerListCtrl()
	EndIf
	Return $regplace <> -1
EndFunc

Func morePlayersAnnouncements($playerAmt)
	For $i = 0 to UBound($morePlayersAnnouncements) - 1
		$tmpAr = StringSplit($morePlayersAnnouncements[$i], ",")
		$announcementAmt = Int($tmpAr[1])
		$announcementText = $tmpAr[2]
		If $playerAmt == $announcementAmt Then
			channelText($announcementText)
			comChannelText($announcementText)
		EndIf
	Next
EndFunc

Func getAllLines() ; Returns lines in reverse chronological
	$prevmousepos = MouseGetPos()
	Local $thelines[7], $channelliney
	$channelliney = $comchatpos[1] - 30;
	MouseClick("left", $comchatpos[0], $channelliney, 1, 2)
	Sleep(50)
	For $line = 6 to 0 Step -1
		Send("{CTRLDOWN}c{CTRLUP}") ; Copy the text
		Sleep(100)
		$thelines[$line] = ClipGet()
		Send("{UP}")
		Sleep(100)
	Next
	MouseMove($prevmousepos[0], $prevmousepos[1], 0)
	return $thelines
EndFunc

Func chatPairingsFromClipboard() ; Enter the pairings which should be in the clipboard.
	$cliptext = ClipGet()
	If @error == 1 then
		MsgBox(262144, "Error", "No text on clipboard!")
	EndIf
	$roundNum = GUICtrlRead($roundLeftClicker)

	channelText("/me [sSET ZEN R] [sLizard]Pairings for Round " & $roundNum & ":[sSET ZEN R]" )
	$array = StringSplit($cliptext, @CR, 1)
	For $linenum = 1 to $array[0]
		$line = $array[$linenum]
		If StringInStr($line, "* BYE *") <> 0 Then
			$regexp = StringRegExp($line, "^\s*\d*\s*(.+?)\,.*$", 1)
			if @error = 0 Then
				channelText("/me : " & $regexp[0] & " has a BYE")
			EndIf
		Else
			;  30	redxny, x	 13	Throoper, x
			$regexp = StringRegExp($line, "^\s*\d*\s*(.+?)\,\s*(x|New Player|NP|OP|LE)?\s+[-\d]*\s*\d+\s+(.+?)\,.*$", 1)
			if @error = 0 Then
				channelText("/me : " & $regexp[0] & " vs. " & $regexp[2] )
			EndIf
		EndIf
	Next
	channelText("/me [sSET ALA R] [sLizard]Good luck everyone![sLizard] [sSET ALA R]")
	comChannelText("/me [sSET ALA R] ROUND " & $roundNum & " RESULTS [sSET ALA R]")
EndFunc

Func chatResultsFromClipboard() ; Enter the pairings which should be in the clipboard.
	$cliptext = ClipGet()
	If @error == 1 then
		MsgBox(262144, "Error", "No text on clipboard!")
	EndIf
	$array = StringSplit($cliptext, @CR, 1)
	$roundNum = GUICtrlRead($roundLeftClicker)
	comChannelText("/me [sSET ZEN R] [sLizard] Round " & $roundNum & " complete.  Check your results in /join " & $normalChannelName)
    channelText("/me [sSET ZEN R] [sLizard] Results for Round " & $roundNum & ":[sSET ZEN R]" )
	For $linenum = 1 to $array[0]
		$line = $array[$linenum]
		If StringInStr($line, "* BYE *") <> 0 Then
			$regexp = StringRegExp($line, "^\s*\d*\s*(.+?)\,.*$", 1)
			if @error = 0 Then
				channelText("/me : " & $regexp[0] & " had a BYE")
			EndIf
		Else
			;  30	redxny, x	 13	Throoper, x
			$regexp = StringRegExp($line, "^\s*(.+?)\,\s*(x|New Player|NP|OP|LE)?\s+(.+?)\,\s*(x|New Player|NP|OP|LE)?\D*(\d)-(\d)\s*$", 1)
			if @error = 0 Then
				$winner = $regexp[0]
				$loser = $regexp[2]
				$winnerscore = $regexp[4]
				$loserscore = $regexp[5]
				if Int( $regexp[4] ) < Int( $regexp[5]) Then
					$tmp = $winner
					$winner = $loser
					$loser = $tmp
					$tmp = $winnerscore
					$winnerscore = $loserscore
					$loserscore = $tmp
				EndIf
				channelText("/me : " & $winner & " defeated " & $loser & ", " & $winnerscore & "-" & $loserscore)
			EndIf
		EndIf
	Next
	channelText("/me [sSET ZEN R] [sLizard]Please check your results for errors.  The next round starts in 2 minutes![sSET ZEN R]")
	$roundNum = $roundNum + 1
	GUICtrlSetData($roundLeftClicker, $roundNum)
	$matchesInNextRound = Floor($registeredplayers / 2)
	GUICtrlSetData($matchesLeftClicker, $matchesInNextRound)
EndFunc

Func chatFromClipboardSlowly() ; Enter the text slowly.
	$cliptext = ClipGet()
	If @error == 1 then
		MsgBox(262144, "Error", "No text on clipboard!")
	EndIf
	$array = StringSplit($cliptext, @CR, 1)

	For $linenum = 1 to $array[0]
		$line = $array[$linenum]
		$line = StringStripWS($line, 3)
		channelText($line)
		Sleep(2000)
	Next
EndFunc

Func chatMatchesLeft() ; Chat the number of matches left to the channel
	$roundNum = GUICtrlRead($roundLeftClicker)
	$matchesLeft = GUICtrlRead($matchesLeftClicker)
	$annText = "/me [sSET CHK C] " & $matchesLeft & " matches remaining in round " & $roundNum
	if $matchesLeft = 1 Then
		$annText = "/me [sSET CHK R] 1 match remaining in round " & $roundNum & ".."
	ElseIf $matchesLeft = 2 Then
		$annText = "/me [sSET CHK U] 2 matches remaining in round " & $roundNum & "."
	EndIf
	channelText($annText)
	comChannelText($annText)
EndFunc

Func RandomlyPickPlayer()
	SRandom(@MSEC)
	$playerNum = Random(0, $registeredplayers - 1, 1)
	MsgBox(262144, "Random Player", "The Player Chosen is: " & $RegisteredPlayerArray[$playerNum])
EndFunc

Func ClipPutPlayerList()
	If $registeredPlayers == 0 Then
		Return
	EndIf
	$playerListText = $RegisteredPlayerArray[0]
	For $i = 1 to ($registeredplayers - 1)
		$playerListText = $playerListText & ", " & $RegisteredPlayerArray[$i]
	Next
	ClipPut($playerListText)
EndFunc

Func ArraySortInsensitive($origList, $numElements)
	Local $newList[UBound($origList)+1]
	Local $minPos
	For $insertPos = 0 to $numElements-1
		$minPos = -1
		For $arPos = 0 to $numElements-1
			If $minPos == -1 and Not ($origList[$arPos] == "") Then
				$minPos = $arPos
			ElseIf Not ($origList[$arPos] == "") And (StringCompare($origList[$arPos], $origList[$minPos], 2) < 0) Then
				$minPos = $arPos
			EndIf
		Next
		$newList[$insertPos] = $origList[$minPos]
		$origList[$minPos] = ""
	Next
	Return $newList
EndFunc
