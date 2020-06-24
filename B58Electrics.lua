--[[
*****************************************************************************************
* Program Script Name	:	B58Electrics.lus

* Author Name			:	Dave Roberts
*
*   Revisions:
*   -- DATE --	--- REV NO ---		--- DESCRIPTION ---
*   2020-01-25	0.01a				      Start of Dev
*
* Description: Sets up the magnetos and power switches for the B58

--]]

local ignition_on = dataref_table("sim/cockpit/engine/ignition_on")
local gen_on = dataref_table("sim/cockpit2/electrical/generator_on")
local my_magneto_value

local left_magneto_switch =  511     -- put your joystick no. here for the left magneto switch
local right_magneto_switch = 512     -- and here for the right one
local alt_switch = 493

function set_electrics()
    -- calculate the value
    if button(left_magneto_switch) then
        my_magneto_value = 1
    else
        my_magneto_value = 0
    end
    if button(right_magneto_switch) then
        my_magneto_value = my_magneto_value + 2
    end
	
	if button(left_magneto_switch) or button(right_magneto_switch) then
		-- push the value into X-Plane's DataRef
		ignition_on[0] = my_magneto_value
		ignition_on[1] = my_magneto_value
	end
	
	if button(alt_switch) then
		gen_on[0] = 0
		gen_on[1] = 0
	end
	
	if not button(alt_switch) then
		gen_on[0] = 1
		gen_on[1] = 1
	end
end
logMsg("Loading B58 Electrics")
do_every_frame("set_electrics()")

