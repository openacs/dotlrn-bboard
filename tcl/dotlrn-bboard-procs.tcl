#
#  Copyright (C) 2001, 2002 OpenForce, Inc.
#
#  This file is part of dotLRN.
#
#  dotLRN is free software; you can redistribute it and/or modify it under the
#  terms of the GNU General Public License as published by the Free Software
#  Foundation; either version 2 of the License, or (at your option) any later
#  version.
#
#  dotLRN is distributed in the hope that it will be useful, but WITHOUT ANY
#  WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS
#  FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more
#  details.
#

ad_library {

    Procs to set up the dotLRN Bboard applet

    @author ben@openforce.net,arjun@openforce.net
    @creation-date 2001-10-05
    @version $Id$
}

namespace eval dotlrn_bboard {

    ad_proc -public applet_key {} {
        get the applet key
    } {
        return "dotlrn_bboard"
    }

    ad_proc -public package_key {
    } {
        get the package_key this applet deals with
    } {
        return "sloan-bboard"
    }

    ad_proc -public get_pretty_name {
    } {
        returns the pretty name
    } {
        return "dotLRN Discussion Forums"
    }

    ad_proc -public add_applet {
    } {
        Add the bboard applet to dotlrn - for one-time init
        Must be repeatable!
    } {
        # register/activate self with dotlrn
        # our service contract is in the db, but we must tell dotlrn
        # that we exist and want to be active
        if {![dotlrn_applet::is_applet_mounted -url "bboard"]} {
            dotlrn_applet::add_applet_to_dotlrn -applet_key [applet_key]

            # Mount the package
            dotlrn_applet::mount -package_key "dotlrn-bboard" -url "bboard" -pretty_name "Bboards"
        }
    }

    ad_proc -public remove_applet {
    } {
        remove the applet from dotlrn
    } {
    }

    ad_proc -public add_applet_to_community {
        community_id
    } {
        Add the bboard applet to a dotlrn community
    } {
        set portal_id [dotlrn_community::get_portal_id \
                -community_id $community_id
        ]

        if {[dotlrn_community::dummy_comm_p -community_id $community_id]} {
            bboard_portlet::add_self_to_page -portal_id $portal_id -package_id 0
            return
        }

        # Create and Mount
        set package_id [dotlrn::instantiate_and_mount \
                -mount_point "forums" \
                $community_id\
                [package_key]
        ]

        set auto_create_forum_p [ad_parameter \
            -package_id [apm_package_id_from_key "dotlrn-bboard"] \
            "auto_create_forum_p" "f" \
        ]

        set auto_create_forum_name [ad_parameter \
            -package_id [apm_package_id_from_key "dotlrn-bboard"] \
            "auto_create_forum_name" "Discussions" \
        ]

        if {$auto_create_forum_p == "t"} {
            # set up a forum inside that instance, with context set to the
            # package ID of the bboard package
            bboard_forum_new \
                -bboard_id $package_id \
                -short_name $auto_create_forum_name \
                -context_id $package_id
        }

        bboard_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id

        # set up the DS for the admin page
        set admin_portal_id [dotlrn_community::get_admin_portal_id \
                -community_id $community_id
        ]
        bboard_admin_portlet::add_self_to_page -portal_id $admin_portal_id -package_id $package_id

        # Set up permissions for basic members (Admins inherit no problem)
        set members [dotlrn_community::get_rel_segment_id \
                -community_id $community_id \
                -rel_type dotlrn_member_rel
        ]
        ad_permission_grant $members $package_id bboard_read_forum
        ad_permission_grant $members $package_id bboard_read_category
        ad_permission_grant $members $package_id bboard_read_message
        ad_permission_grant $members $package_id bboard_create_message

        # return the package_id
        return $package_id
    }

    ad_proc -public remove_applet_from_community {
        community_id
    } {
        remove the applet from the given community
    } {
        ad_return_complaint 1 "aks1"
    }

    ad_proc -public add_user {
        community_id
    } {
        Called when the user is initially added as a dotlrn user.
        For one-time init stuff
    } {
    }

    ad_proc -public remove_user {
        user_id
    } {
    } {
    }

    ad_proc -public add_user_to_community {
        community_id
        user_id
    } {
        Add a user to a specific dotlrn community
    } {
        set package_id [dotlrn_community::get_applet_package_id \
                $community_id \
                [applet_key]
        ]
        set portal_id [dotlrn::get_workspace_portal_id $user_id]

        set element_id [bboard_portlet::add_self_to_page -portal_id $portal_id -package_id $package_id]
        portal::set_element_param $element_id "display_group_name_p" "t"
    }

    ad_proc -public remove_user_from_community {
        community_id
        user_id
    } {
        Remove a user from a community
    } {
        set package_id [dotlrn_community::get_applet_package_id \
                $community_id \
                [applet_key]
        ]
        set portal_id [dotlrn::get_workspace_portal_id $user_id]

        bboard_portlet::remove_self_from_page $portal_id $package_id
    }

    ad_proc -public add_portlet {
        args
    } {
        A helper proc to add the underlying portlet to the given portal. 
        
        @param args a list-ified array of args defined in add_applet_to_community
    } {
        ns_log notice "** Error in [get_pretty_name]: 'add_portlet' not implemented!"
        ad_return_complaint 1  "Please notifiy the administrator of this error:
        ** Error in [get_pretty_name]: 'add_portlet' not implemented!"
    }

    ad_proc -public remove_portlet {
        args
    } {
        A helper proc to remove the underlying portlet from the given portal. 
        
        @param args a list-ified array of args defined in remove_applet_from_community
    } {
        ns_log notice "** Error in [get_pretty_name]: 'remove_portlet' not implemented!"
        ad_return_complaint 1  "Please notifiy the administrator of this error:
        ** Error in [get_pretty_name]: 'remove_portlet' not implemented!"
    }

    ad_proc -public clone {
        old_community_id
        new_community_id
    } {
        Clone this applet's content from the old community to the new one
    } {
        ns_log notice "** Error in [get_pretty_name] 'clone' not implemented!"
        ad_return_complaint 1  "Please notifiy the administrator of this error:
        ** Error in [get_pretty_name]: 'clone' not implemented!"
    }

}
