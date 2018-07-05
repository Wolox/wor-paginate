# Sometimes it's a README fix, or something like that - which isn't relevant for
# including in a project's CHANGELOG for example
declared_trivial = github.pr_title.include? "#trivial"

# Make it more obvious that a PR is a work in progress and shouldn't be merged yet
warn("PR is classed as Work in Progress") if github.pr_title.include? "[WIP]"

# Warn when there is a big PR
warn("Big PR. If it's possible try to reduce this into smaller PR's") if git.lines_of_code > 500

# Warn when a PR is clased as work in progress
warn "PR is classed as Work in Progress" if github.pr_title.include? "[WIP]"

# Don't let testing shortcuts get into master by accident
fail("fdescribe left in tests") if `grep -r fdescribe specs/ `.length > 1
fail("fit left in tests") if `grep -r fit specs/ `.length > 1

# Ensure there's a summary on the pull request description
fail "Please provide a summary in the Pull Request description" if github.pr_body.length < 5

can_merge = github.pr_json["mergeable"]
fail("This PR cannot be merged yet. Please fix the conflicts with the base branch", sticky: false) unless can_merge

todoist.message = "Please fix all TODOS"
todoist.fail_for_todos

changelog.check unless declared_trivial
