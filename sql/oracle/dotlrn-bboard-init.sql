
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
end;
/
show errors
