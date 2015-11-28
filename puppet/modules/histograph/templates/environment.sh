# <%= @environment_file %> is set by puppet.

PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games"

<% @variables.keys.sort.each do |key| -%>
<%= key.upcase %>="<%= @environment[key] %>"
<% end -%>

