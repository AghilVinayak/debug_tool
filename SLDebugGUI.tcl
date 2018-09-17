#!/usr/local/bin/wish

#Create notebook and pages
ttk::notebook .n -padding "5 5 12 12"
ttk::frame .n.p1 -padding "5 5 12 12"
ttk::frame .n.p2 -padding "5 5 12 12"
ttk::frame .n.p3 -padding "5 5 12 12"
ttk::frame .n.p4 -padding "5 5 12 12"

# Create a frame for quit.
frame .top -borderwidth 5
button .top.quit -text Quit -relief groove -command exit 
label .top.logo -image [image create photo -file SaankhyaLogoGif.gif]
label .top.cpuSell -text CPU
entry .top.cpuSelect -width 7 -textvariable cpuSelect
pack .top -side top -fill x
pack .top.quit -side right -padx 2
pack .top.logo -side left -padx 2
pack .top.cpuSell -side left -padx 2
pack .top.cpuSelect -side left -padx 2

frame .status -borderwidth 1
label .status.jtag -textvariable jtagStatus
label .status.boardConnection -textvariable boardConnectionStatus
pack .status -side bottom -fill x
pack .status.jtag -side left
pack .status.boardConnection -side right

global devIdValue
set devIdValue "Not available"
set jtagStatus "JTAG disconnected"
set boardConnectionStatus "DeviceID : $devIdValue"

wm title . "SaankhyaLabs Debugging Tool"
wm withdraw .
wm state . normal

.n add .n.p1 -text "General" 
.n add .n.p2 -text "GPR"
.n add .n.p3 -text "Memory"
.n add .n.p4 -text "support"

# Below selection if GUI frame work
if 1 {
#Page 1Row 0
grid [ttk::label .n.p1.portlbl -text Port] -column 0 -row 0 -sticky w
grid [ttk::entry .n.p1.portNumber -width 7 -textvariable portNumber] -column 1 -row 0 -sticky w
grid [ttk::button .n.p1.connect -text CONNECT -command clickConnect] -column 2 -row 0 -sticky w
#Page 1 Row 1
grid [ttk::label .n.p1.breakPointlbl -text beakPoint] -column 0 -row 1 -sticky w
grid [ttk::entry .n.p1.breakPointAddr -width 10 -textvariable breakPointAddr] -column 1 -row 1 -sticky w
grid [ttk::button .n.p1.setbkpt -text SET -command clickSetBreakpoint] -column 2 -row 1 -sticky w
grid [ttk::button .n.p1.removebkpt -text REMOVE -command clickRemove] -column 3 -row 1 -sticky w
#Page 1 Row 2
grid [ttk::label .n.p1.wtptlbl -text watchPoint] -column 0 -row 2 -sticky w
grid [ttk::entry .n.p1.watchPointId -width 10 -textvariable watchPointId] -column 1 -row 2 -sticky e
grid [ttk::entry .n.p1.watchPointAddr -width 10 -textvariable watchPointAddr] -column 2 -row 2 -sticky w
grid [ttk::entry .n.p1.watchPointVal -width 10 -textvariable watchPointVal] -column 3 -row 2 -sticky w
grid [ttk::entry .n.p1.watchPointLoadStore -width 5  -textvariable watchPointLoadStore] -column 4 -row 2 -sticky w
grid [ttk::button .n.p1.setwtpt -text SET -command clickWtpt] -column 5 -row 2 -sticky w
#Page 1 Row 3
grid [ttk::button .n.p1.sconSel -text SCON -command sconSelCpu] -column 0 -row 3 -sticky w
grid [ttk::button .n.p1.sp1Sel -text SP1 -command sp1SelCpu] -column 1 -row 3 -sticky w
grid [ttk::button .n.p1.sp2Sel -text SP2 -command sp2SelCpu] -column 2 -row 3 -sticky w
grid [ttk::button .n.p1.vitSel -text VIT -command vitSelCpu] -column 3 -row 3 -sticky w
grid [ttk::button .n.p1.rsSel -text RS -command rsSelCpu] -column 4 -row 3 -sticky w
grid [ttk::button .n.p1.stallCpu -text STALL -command clickStallCpu] -column 5 -row 3 -sticky w
grid [ttk::button .n.p1.runCpu -text RUN -command clickRunCpu] -column 6 -row 3 -sticky w
#Page 1 Row 4
grid [ttk::label .n.p1.sconPcValue -textvariable sconPcValue] -column 0 -row 4 
grid [ttk::label .n.p1.sp1PcValue -textvariable sp1PcValue] -column 1 -row 4 
grid [ttk::label .n.p1.sp2PcValue -textvariable sp2PcValue] -column 2 -row 4 
grid [ttk::label .n.p1.vitPcValue -textvariable vitPcValue] -column 3 -row 4
grid [ttk::label .n.p1.rsPcValue -textvariable rsPcValue] -column 4 -row 4 
grid [ttk::button .n.p1.checkPc -text CHECK\ PC -command clickCheckPC] -column 5 -row 4 
grid [ttk::button .n.p1.singleIns -text SI -command clicksingleIns] -column 6 -row 4 -sticky w
#Page1 Row 5
grid [tk::text .n.p1.text -width 90 -height 10] -column 0 -row 5 -rowspan 1 -columnspan 7 -sticky w 
#Page 2 
grid [ttk::button .n.p2.updateReg -text UPDATE\ GPR -command clickUpdateReg] -column 6 -row 0 -sticky w
grid [ttk::radiobutton .n.p2.decimalButton -text dec -variable displayFormat -value decimal ] -row 2 -column 6
grid [ttk::radiobutton .n.p2.hexadecimalButton -text hex -variable displayFormat -value hexadecimal ] -row 3 -column 6
#Page 3
grid [ttk::entry .n.p3.e_memStartAddr -width 16 -textvariable e_memStartAddr] -column 6 -row 0 -sticky w
grid [ttk::button .n.p3.b_updateMem -text UPDATE\ MEM -command clickUpdateMem] -column 6 -row 1 -sticky w
grid [ttk::radiobutton .n.p3.bp3_decimalButton -text dec -variable bp3_displayFormat -value decimal ] -row 2 -column 6
grid [ttk::radiobutton .n.p3.bp3_hexadecimalButton -text hex -variable bp3_displayFormat -value hexadecimal ] -row 3 -column 6
grid [ttk::entry .n.p3.e_memLength -width 16 -textvariable e_memLength] -column 6 -row 4 -sticky w
grid [ttk::entry .n.p3.e_filename -width 16 -textvariable e_filename] -column 6 -row 5 -sticky w
grid [ttk::button .n.p3.b_Mem2FileDump -text FILE\ DUMP -command clickMem2File] -column 6 -row 6 -sticky w
#Page 4
#grid [ttk::label .n.p4.support -text aghil.vinayak@saankhyalabs.com] -column 0 -row 0 -sticky w
grid [ttk::button .n.p4.misc -text SHOW\ MODULATOR\ STATUS -command clickMisc] -column 0 -row 1 -sticky w
}

global CPU

set GPRCount 64
set k 0
for {set i 0} {$i < 13} {incr i} {

	grid [ttk::label .n.p2.regl{$i} -text reg$k] -column 0 -row $i -sticky w
	
        for {set j 0} {$j < 5} {incr j} {
			set temp $i$j
            grid [ttk::entry .n.p2.l{$k} -width 10 -textvariable l{$k}] -row $i -column [ expr {$j + 1 }] -padx 2 -pady 2
			set  ::l{$k} $k
			incr k
			if {$k == 64} {
				set k 0
				break;
			}
        }
    }

set MemoryCount 64
for {set i 0} {$i < 13} {incr i} {

	grid [ttk::label .n.p3.meml{$i} -text mem$k] -column 0 -row $i -sticky w
	
        for {set j 0} {$j < 5} {incr j} {
			set temp $i$j
            grid [ttk::entry .n.p3.e_mem{$k} -width 10 -textvariable entryMem{$k}] -row $i -column [ expr {$j + 1 }] -padx 2 -pady 2
			set  ::entryMem{$k} $k
			incr k
			if {$k == 64} {
				set k 0
				break;
			}
        }
    }
	
	

	

set CPU sproc1

set ::portNumber 1111
set ::breakPointAddr "Address"
set ::watchPointId "ID"
set ::watchPointAddr "Address"
set ::watchPointVal "Value"
set ::watchPointLoadStore "l|s"
set cpuSelect "NA"
set ::e_memStartAddr "Memory Start Addr"
set ::e_memLength "Length in words"
set ::e_filename "Filename.bin"
set ::bp3_displayFormat "hexadecimal"
set ::displayFormat "hexadecimal"

foreach w [winfo children .n.p1] {grid configure $w -padx 2 -pady 2}
focus .n.p1.portNumber
#bind . <Return> {clickConnect}

pack .n

proc checkModOrDemod { modDemodID } {

	switch $modDemodID {
		64 {
			set modDemodName "MODULATOR I2C";
		}
		128 {
			set modDemodName "MODULATOR I2C";
		}
		192 {
			set modDemodName "DE-MODULATOR I2C";
		}
		96 {
			set modDemodName "DE-MODULATOR I2C";
		}
		32 {
			set modDemodName "RANGING I2C";
		}
		99 {
			set modDemodName "TDA18275A I2C";
		}
		198 {
			set modDemodName "TDA18275A I2C";
		}
		default {
			set modDemodName "ERROR--INVALID CONNECTION ON BOARD !!";
		}
	}

	return $modDemodName
}

# Procedure to know the connection
proc checkChipId { chipId } {

	switch $chipId {
		1 {
			set modDemodName "MODULATOR MODE";
		}
		0 {
			set modDemodName "DE-MODULATOR MODE";
		}
		default {
			set modDemodName "ERROR--INVALID MODE";
		}
	}

	return $modDemodName
}

proc clickConnect {} {
   if {[catch {
		global jtagStatus
		global boardConnectionStatus
		set port [expr {round($::portNumber)}]
		load sdb.so; connect 127.0.0.1 $port 1
		set jtagStatus "JTAG connected"
		
		set boardConnectionaddress 0x8014
		set boardConnection [ Dump mem $boardConnectionaddress 1 ]
		set boardConnection [ expr ($boardConnection) ]
		set boardConnection [ checkModOrDemod $boardConnection]

		set chipOnBoardaddress 0xe938c
		set chipOnBoard [ Dump mem $chipOnBoardaddress 1 ]
		set chipOnBoard [ expr ($chipOnBoard) ]
		set chipOnBoard [ checkChipId $chipOnBoard]
		
		set boardConnectionStatus "$boardConnection"
		puts "Chip on Board 		: $chipOnBoard"
		puts "Board Connected 	: $boardConnection"
		
   }]!=0} {
	puts "Run JTAG server and check JTAG server port address"
   }
}

proc clickSetBreakpoint {} {
   if {[catch {
       set bkptAddr $::breakPointAddr
       puts $bkptAddr
       #Setmem $bkptAddr 0x200000
       #Dump mem $bkptAddr 1
	   stall
	   setbkpt $bkptAddr
   }]!=0} {
	puts "ERROR"
   }
}

proc clickWtpt {} {
   if {[catch {
       puts "NEW"
	   puts $::watchPointId
	   puts $::watchPointAddr
	   puts $::watchPointVal
	   puts $::watchPointLoadStore
	   
	   setwtpt $::watchPointId = $::watchPointAddr = $::watchPointVal $::watchPointLoadStore
   }]!=0} {
	puts "ERROR"
   }
}

proc clickRemove {} {
   if {[catch {
       set bkptAddr $::breakPointAddr
       puts $bkptAddr
       Setmem $bkptAddr 0x0
       Dump mem $bkptAddr 1
   }]!=0} {
	puts "ERROR"
   }
}

proc clickRunCpu {} {
   if {[catch {
       stall;run
   }]!=0} {
	puts "ERROR"
   }
}

proc clickStallCpu {} {
   if {[catch {
       stall;
   }]!=0} {
	puts "ERROR"
   }
}

proc clicksingleIns {} {
   if {[catch {
	puts "SI"
       si
   }]!=0} {
	puts "ERROR"
   }
}

proc sconSelCpu {} {
   if {[catch {
	global CPU
	global cpuSelect
#	puts "SCON"
	set CPU sigcon
	setdevice $CPU
	set cpuSelect $CPU
   }]!=0} {
	puts "ERROR"
   }
}

proc sp1SelCpu {} {
   if {[catch {
	global CPU
	global cpuSelect
#	puts "SP1"
	set CPU sproc1
	setdevice $CPU
	set cpuSelect $CPU
   }]!=0} {
	puts "ERROR"
   }
}

proc sp2SelCpu {} {
   if {[catch {
	global CPU
	global cpuSelect
#	puts "SP2"
	set CPU sproc2
	setdevice $CPU
	set cpuSelect $CPU	
   }]!=0} {
	puts "ERROR"
   }
}

proc vitSelCpu {} {
   if {[catch {
	global CPU
	global cpuSelect
#	puts "VIT"
	set CPU viterbi
	setdevice $CPU
	set cpuSelect $CPU	
   }]!=0} {
	puts "ERROR"
   }
}

proc rsSelCpu {} {
   if {[catch {
	global CPU
	global cpuSelect
#	puts "RS"
	set CPU rs
	setdevice $CPU
	set cpuSelect $CPU	
   }]!=0} {
	puts "ERROR"
   }
}

proc clickCheckPC {} {
   if {[catch {
	global CPU	   
	puts "CHECK PC"

	setdevice sigcon
	set ::sconPcValue [Dump pc]
	setdevice sproc1
	set ::sp1PcValue [ Dump pc]
	setdevice sproc2
	set ::sp2PcValue [ Dump pc]
	setdevice viterbi
	set ::vitPcValue [ Dump pc]
	setdevice rs
	set ::rsPcValue [ Dump pc]
	
	setdevice $CPU

   }]!=0} {
	puts "ERROR"
   }
}

proc clickUpdateReg {} {
	global k
   if {[catch {
	puts "UPDATE GPR"
	
	for {set i 0} {$i < 13} {incr i} {	
        for {set j 0} {$j < 5} {incr j} {
			set regVal [Dump gpr $k $k]
			if {$::displayFormat == "decimal"} {
				set regVal [expr $regVal]
			}
			set  ::l{$k} $regVal
			incr k
			if {$k == 64} {
				set k 0
				break;
			}
        }
    }

	
	
   }]!=0} {
	puts "ERROR"
   }
}

proc clickUpdateMem {} {

	global k
	set temp $::e_memStartAddr

   if {[catch {
	puts "UPDATE MEM"
	
	for {set i 0} {$i < 13} {incr i} {	
        for {set j 0} {$j < 5} {incr j} {
			set memVal [Dump mem $temp 1]
			if {$::bp3_displayFormat == "decimal"} {
				set memVal [expr $memVal]
			}
			set  ::entryMem{$k} $memVal
			incr k
			set temp [expr {$temp + 4} ]
			if {$k == 64} {
				set k 0
				break;
			}
        }
    }

	
	
   }]!=0} {
	puts "ERROR"
   }
}

proc clickMem2File {} {
   if {[catch {
		puts "DUMP MEM TO FILE"
		stall
		set temp1 $::e_memStartAddr
		set temp2 $::e_memLength
		set temp3 $::e_filename
		dump mem $temp1 $temp2 $temp3
		  
   }]!=0} {
	puts "ERROR"
   }
}


proc clickMisc {} {
   if {[catch {
		#source sp1Info.tcl
		
		puts "Add your requirements"
		source tvwsDownlinkModulatorHelp.tcl 
		  
   }]!=0} {
	puts "ERROR"
   }
}



