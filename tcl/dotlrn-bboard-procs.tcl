

#
# Procs for DOTLRN Bboard Applet
# Copyright 2001 OpenForce, inc.
# Distributed under the GNU GPL v2
#
# October 5th, 2001
#

ad_library {
    
    Procs to set up the dotLRN Bboard applet
    
    @author ben@openforce.net,arjun@openforce.net
    @creation-date 2001-10-05
    
}

namespace eval dotlrn_bboard {
    
    ad_proc -public package_key {
    } {
	get the package_key this applet deals with
    } {
	return "bboard"
    }

    ad_proc portal_element_key {
    } {
	return the portal element key
    } {
	return "bboard-portlet"
    }

    ad_proc -public get_pretty_name {
    } {
	returns the pretty name
    } {
	return "dotLRN Discussion Forums"
    }

    ad_proc -public add_applet {
	community_id
    } {
	Add the bboard applet
    } {
	# Create and Mount
	set package_key [package_key]
	set package_id [dotlrn::instantiate_and_mount $community_id $package_key]

	# set up a forum inside that instance
	bboard_forum_new -bboard_id $package_id -short_name "Discussions"

	# get the portal_template_id by callback
	set pt_id [dotlrn_community::get_portal_template_id $community_id]

	# set up the DS for the portal template
	bboard_portlet::make_self_available $pt_id
	bboard_portlet::add_self_to_page $pt_id $package_id

	# return the package_id
	return $package_id
    }

    ad_proc -public remove_applet {
	community_id
	package_id
    } {
	remove the applet from the community
    } {
	# Remove all instances of the bboard portlet! (this is some serious stuff!)

	# Dropping all messages, forums

	# Killing the package
    
    }

    ad_proc -public add_user {
	community_id
	user_id
    } {
	Add a user to a community
    } {
	# Get the page_id by callback
	set page_id [dotlrn_community::get_page_id $community_id $user_id]
	
	# Get the package_id by callback
	set package_id [dotlrn_community::get_applet_package_id $community_id dotlrn_bboard]

	# Allow user to see the bboard forums
	# nothing for now

	# Make bboard DS available to this page
	bboard_portlet::make_self_available $page_id

	# Call the portal element to be added correctly
	bboard_portlet::add_self_to_page $page_id $package_id

	# Now for the user workspace
	set workspace_page_id [dotlrn_community::get_workspace_page_id $user_id]

	# Add the portlet here
	bboard_portlet::add_self_to_page $workspace_page_id $package_id
    }

    ad_proc -public remove_user {
	community_id
	user_id
    } {
	Remove a user from a community
    } {
	# Get the page_id
	set page_id [dotlrn_community::get_page_id $community_id $user_id]
	
	# Get the package_id by callback
	set package_id [dotlrn_community::get_package_id $community_id]

	# Remove the portal element
	bboard_portlet::remove_self_from_page $page_id $package_id

	# Buh Bye.
	bboard_portlet::make_self_unavailable $page_id

	# remove user permissions to see bboards
	# nothing to do here

	# Remove from the main workspace
	set workspace_page_id [dotlrn_community::get_workspace_page_id $user_id]

	# Add the portlet here
	bboard_portlet::remove_self_from_page $workspace_page_id $package_id
    }
	
}
