include Grit

r = Repo.new '/www/aboutus/dotcom'
commit = r.commits.first
diff = commit.diffs.first.diff
differ = Diff::Display::Unified.new(diff)

puts differ.render(Diff::Renderer::InlineTableCallback.new)
