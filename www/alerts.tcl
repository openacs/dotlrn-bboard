ad_page_contract {
    This is the central interface for managing a user's subscriptions.

    @author Anukul Kapoor <akk@arsdigita.com>
    @creation-date 2001-03-27
    @cvs-id $Id$
} {
} -properties {
    forum_subs:multirow
    category_subs:multirow
    thread_subs:multirow
}

ad_maybe_redirect_for_registration

set user_id [ad_verify_and_get_user_id]

# three sorts of subscriptions:
#  forums

db_multirow forum_subs get_forum_subs {
    select bfs.forum_id, short_name as name, bf.bboard_id
      from bboard_forum_subscribers bfs, bboard_forums bf
      where bfs.forum_id = bf.forum_id
            and bfs.subscriber_id = :user_id
      order by forum_id asc
}

#  categories
db_multirow category_subs get_category_subs {
    select bcs.category_id, bc.short_name as name, bf.forum_id, bf.bboard_id, bf.short_name as bboard_name
      from bboard_category_subscribers bcs, bboard_categories bc, bboard_forums bf
      where bcs.category_id = bc.category_id
            and bcs.subscriber_id = :user_id
            and bc.forum_id = bf.forum_id
      order by category_id asc
}


#  threads

db_multirow thread_subs get_thread_subs {
    select thread_id, title as name, bf.forum_id, bf.bboard_id, bf.short_name as bboard_name
      from bboard_thread_subscribers bts, bboard_messages_all bma, bboard_forums bf
      where bts.thread_id = bma.message_id
            and bts.subscriber_id = :user_id
            and bma.forum_id= bf.forum_id
      order by thread_id asc
}

set this_url [ad_conn url]

ad_return_template
