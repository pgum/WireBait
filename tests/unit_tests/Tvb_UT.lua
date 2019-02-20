---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by markus.
--- DateTime: 2/19/19 7:11 PM
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

local Tvb       = require("wirebaitlib.packet_data.Tvb");
local ByteArray = require("wirebaitlib.primitives.ByteArray");

--[[ All variables here need to be kept local, however the unit test framework will run
each individual test function added with UnitTestsSet:addTest() in its own environment,
therefore forgetting the local keyword will not have a negative impact.
]]--
--Creating unit tests
local unit_tests = tester.newUnitTestsSet("Tvb Unit Tests");

unit_tests:addTest("Testing Tvb construction", function()
    local b = ByteArray.new("A0102FB1");
    local tvb_range = Tvb.new(b);
    tester.assert(tvb_range.m_data, b, "Wrong underlying data");
    tester.assert(tvb_range:len(), 4, "Wrong size after construction")
end);

unit_tests:addTest("Testing Tvb:len()", function()
    tester.assert(Tvb.new(ByteArray.new("4845")):len(), 2, "Wrong byte length");
end)

unit_tests:addTest("Testing Tvb:bytes()", function()
    local b = ByteArray.new("4845");
    tester.assert(Tvb.new(b):bytes(), b, "Tvb:bytes() failed!");
end)

unit_tests:addTest("Testing Tvb:offset()", function()
    tester.assert(Tvb.new(ByteArray.new("4845")):offset(), 0, "Wrong offset");
    tester.assert(Tvb.new(ByteArray.new("4845"), 1):offset(), 1, "Wrong offset");
end)

unit_tests:addTest("Testing Tvb:range()", function()
    local tvb = Tvb.new(ByteArray.new("0102030405060708"));
    tester.assert(tvb:range(0,1)._struct_type, "TvbRange", "Tvb:range() should return a TvbRange!");
    tester.assert(tvb:range(0,1).m_data, ByteArray.new("01"), "Tvb:range() failed!");
    tester.assert(tvb:range(0,3).m_data, ByteArray.new("010203"), "Tvb:range() failed!");
    tester.assert(tvb:range(2,2).m_data, ByteArray.new("0304"), "Tvb:range() failed!");
    tester.assert(tvb:range(4).m_data, ByteArray.new("05060708"), "Tvb:range() failed!");
end)

unit_tests:addTest("Testing Tvb()", function()
    local tvb = Tvb.new(ByteArray.new("0102030405060708"));
    tester.assert(tvb:range(0,1)._struct_type, "TvbRange", "Tvb:range() should return a TvbRange!");
    tester.assert(tvb(0,1).m_data, ByteArray.new("01"), "Tvb:range() failed!");
    tester.assert(tvb(0,3).m_data, ByteArray.new("010203"), "Tvb:range() failed!");
    tester.assert(tvb(2,2).m_data, ByteArray.new("0304"), "Tvb:range() failed!");
    tester.assert(tvb(4).m_data, ByteArray.new("05060708"), "Tvb:range() failed!");
end)

unit_tests:addTest("Testing Tvb:__tostring()", function()
    tester.assert(tostring(Tvb.new(ByteArray.new("4845"))), "4845", "__tostring() failed");
    local b = ByteArray.new("01020304050607080910111213141516171819202122232425262728");
    tester.assert(tostring(Tvb.new(b)), "010203040506070809101112131415161718192021222324...", "__tostring() failed");
end)



if is_standalone_test then
    tester.test(unit_tests);
    tester.printReport();
else
    return unit_tests
end
