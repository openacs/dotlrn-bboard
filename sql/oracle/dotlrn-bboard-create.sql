--
--  Copyright (C) 2001, 2002 OpenForce, Inc.
--
--  This file is part of dotLRN.
--
--  dotLRN is free software; you can redistribute it and/or modify it under the
--  terms of the GNU General Public License as published by the Free Software
--  Foundation; either version 2 of the License, or (at your option) any later
--  version.
--
--  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
--  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
--  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
--  details.
--


--
-- The bboard applet for dotLRN
-- copyright 2001, OpenForce
-- distributed under GPL v2.0
--
--
-- ben,arjun@openforce.net
--
-- 10/05/2001
--


declare
	foo integer;
begin
	-- create the implementation
	foo := acs_sc_impl.new (
		'dotlrn_applet',
		'dotlrn_bboard',
		'dotlrn_bboard'
	);

	-- add all the hooks

	-- GetPrettyName
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'GetPrettyName',
	       'dotlrn_bboard::get_pretty_name',
	       'TCL'
	);

	-- AddApplet
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'AddApplet',
	       'dotlrn_bboard::add_applet',
	       'TCL'
	);

	-- RemoveApplet
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'RemoveApplet',
	       'dotlrn_bboard::remove_applet',
	       'TCL'
	);

	-- AddAppletToCommunity
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'AddAppletToCommunity',
	       'dotlrn_bboard::add_applet_to_community',
	       'TCL'
	);

	-- RemoveAppletFromCommunity
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'RemoveAppletFromCommunity',
	       'dotlrn_bboard::remove_applet_from_community',
	       'TCL'
	);
	-- AddUser
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'AddUser',
	       'dotlrn_bboard::add_user',
	       'TCL'
	);

	-- RemoveUser
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'RemoveUser',
	       'dotlrn_bboard::remove_user',
	       'TCL'
	);

	-- AddUserToCommunity
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'AddUserToCommunity',
	       'dotlrn_bboard::add_user_to_community',
	       'TCL'
	);

	-- RemoveUserFromCommunity
	foo := acs_sc_impl.new_alias (
	       'dotlrn_applet',
	       'dotlrn_bboard',
	       'RemoveUserFromCommunity',
	       'dotlrn_bboard::remove_user_from_community',
	       'TCL'
	);

	-- Add the binding
	acs_sc_binding.new (
	    contract_name => 'dotlrn_applet',
	    impl_name => 'dotlrn_bboard'
	);
end;
/
show errors
