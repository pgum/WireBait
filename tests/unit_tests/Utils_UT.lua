---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by markus.
--- DateTime: 2/18/19 12:34 PM
---

--[[
    WireBait for wirebait is a lua package to help write Wireshark
    Dissectors in lua
    [Wirebait on Github](https://github.com/MarkoPaul0/WireBait)
    Copyright (C) 2015-2017 Markus Leballeux

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
]]
local is_standalone_test = not tester; --if only this file is being tested (not part of run all)
local tester = tester or require("tests.tester")

local utils = require("wirebaitlib.primitives.Utils")

--[[ All variables here need to be kept local, however the unit test framework will run
each individual test function added with UnitTestsSet:addTest() in its own environment,
therefore forgetting the local keyword will not have a negative impact.
]]--
--Creating unit tests
local unit_tests = tester.newUnitTestsSet("Utils Unit Tests");

unit_tests:addTest("Testing Utils.printIP() = 192.168.0.1", function()
    tester.assert(utils.printIP(3232235521), "192.168.0.1", "Wrong IP");
end);

unit_tests:addTest("Testing Utils.printIP() = 224.0.255.255", function()
    tester.assert(utils.printIP(3758161919), "224.0.255.255", "Wrong IP");
end);

--[[
unit_tests:addTest("Testing Utils.swapBytes() (2 bytes)", function()
    tester.assert(utils.swapBytes("0102"), "0201", "swapBytes() failed");
end);

unit_tests:addTest("Testing Utils.swapBytes() (4 bytes)", function()
    tester.assert(utils.swapBytes("01020304"), "04030201", "swapBytes() failed");
end);

unit_tests:addTest("Testing Utils.swapBytes() (8 bytes)", function()
    tester.assert(utils.swapBytes("0102030405060708"), "0807060504030201", "swapBytes() failed");
end);
]]

--[[
unit_tests:addTest("Testing Utils.hexStringToUint32() = 0", function()
    tester.assert(utils.hexStringToUint32("00000000"), 0, "hexStringToUint32() failed");
end);

unit_tests:addTest("Testing Utils.hexStringToUint32() = 1", function()
    tester.assert(utils.hexStringToUint32("00000001"), 1, "hexStringToUint32() failed");
end);

unit_tests:addTest("Testing Utils.hexStringToUint32() = 4294967295", function()
    tester.assert(utils.hexStringToUint32("FFFFFFFF"), 4294967295, "hexStringToUint32() failed");
end);
]]

unit_tests:addTest("Testing Utils.typeof() = number", function()
    tester.assert(utils.typeof(2), "number", "typeof() failed");
end);

unit_tests:addTest("Testing Utils.typeof() = string", function()
    tester.assert(utils.typeof("some string"), "string", "typeof() failed");
end);

unit_tests:addTest("Testing Utils.typeof() = table", function()
    local some_table = {};
    tester.assert(utils.typeof(some_table), "table", "typeof() failed");
end);

unit_tests:addTest("Testing Utils.typeof() = DummyWirebaitType", function()
    local wirebait_struct = {_struct_type = "DummyWirebaitType" };
    tester.assert(utils.typeof(wirebait_struct), "DummyWirebaitType", "typeof() failed");
end);

if is_standalone_test then
    tester.test(unit_tests);
    tester.printReport();
else
    return unit_tests
end
