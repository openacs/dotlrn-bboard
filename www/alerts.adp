<master src="master">
<property name="title">Manage Email Alerts</property>
<property name="text">Bboard Alerts</property>
<property name="return_url">../../</property>
<property name="link_all">1</property>

<h3>Bboard Alerts</h3>

You have registered for the following email alerts. An email alert
will send you an email whenever an update happens in the given
context. For example, a bboard email alert will notify you by email
whenever a new posting occurs in the specific bboard. A thread email
alert, on the other hand, will only alert you if a posting has been
made within that given thread.
<p>

<h4>Bboards</h4>

<ul>

<if @forum_subs:rowcount@ gt 0>
<multiple name="forum_subs">
<% set url_prefix [site_nodes::get_url_from_package_id -package_id $forum_subs(bboard_id)] %>
 <li><a href="@url_prefix@forum?forum_id=@forum_subs.forum_id@"><%= [site_nodes::get_parent_name -instance_id $forum_subs(bboard_id)] %> - @forum_subs.name@</a> [<a href="@url_prefix@forum-unsubscribe?return_url=@this_url@&forum_id=@forum_subs.forum_id@">Unsubscribe</a>]
</multiple>
</if>
<else>
<i>No Bboard Email Alerts</i>
</else>

</ul>

<h4>Categories</h4>

<ul>

<if @category_subs:rowcount@ gt 0>
<multiple name="category_subs">
<% set url_prefix [site_nodes::get_url_from_package_id -package_id $category_subs(bboard_id)] %>
 <li><a href="@url_prefix@forum-by-category?forum_id=@category_subs.forum_id@&category_id=@category_subs.category_id@"><%= [site_nodes::get_parent_name -instance_id $category_subs(bboard_id)] %> - @category_subs.bboard_name@ - @category_subs.name@</a> [<a href="@url_prefix@category-unsubscribe?forum_id=@category_subs.forum_id@&category_id=@category_subs.category_id@&sub_page=t&return_url=@this_url@">Unsubscribe</a>]
</multiple>
</if>
<else>
<i>No Category Email Alerts</i>
</else>
</ul>

<h4>Individual Threads</h4>

<ul>

<if @thread_subs:rowcount@ gt 0>
<multiple name="thread_subs">
<% set url_prefix [site_nodes::get_url_from_package_id -package_id $thread_subs(bboard_id)] %>
 <li><a href="@url_prefix@<%= [bboard_message_url @thread_subs.thread_id@ @thread_subs.forum_id@]%>"><%= [site_nodes::get_parent_name -instance_id $thread_subs(bboard_id)] %> - @thread_subs.bboard_name@ - @thread_subs.name@</a> [<a href="@url_prefix@message-unsubscribe?forum_id=@thread_subs.forum_id@&message_id=@thread_subs.thread_id@&sub_page=t&return_url=@this_url@">Unsubscribe</a>]
</multiple>
</if>
<else>
<i>No Thread Email Alerts</i>
</else>

</ul>

<p />
