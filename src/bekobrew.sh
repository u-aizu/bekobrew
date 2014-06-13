#!/bin/bash
#
# Copyright 2013-2014 Hiroyuki Sano.
#
# Usage: bekobrew {subcommand} [args...]

<%
# 埋め込むソースコードのリスト
list = [
  "makepkg",
  "hello",
]
%>

# usage: invoke_subcommand command arg1
# サブコマンド呼び出し
function invoke_subcommand() {

<% list.each do |x| %>
  function _<%= x %>() { <%= File.read(File.expand_path("../bekobrew/#{x}.sh", __FILE__)) %> }
<% end %>

  # invoke subcommand: e.g. _makepkg
  "_$@"
}

invoke_subcommand "$@"

