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

# Ensures that the PR is mergeable
can_merge = github.pr_json["mergeable"]
fail("This PR cannot be merged yet. Please fix the conflicts with the base branch", sticky: false) unless can_merge

# It fails when TODO's are present
todoist.message = "Please fix all TODOS"
todoist.fail_for_todos

# Check for changes in the CHANGELOG.md if the pr isn't trivial
changelog.check unless declared_trivial

# Fails when an important file is deleted or renamed
[
  'wor-paginate-gemspec',
  'README.md',
  'CHANGELOG.md',
  '.gitignore',
  '.travis.yml',
  '.rubocop.yml'
].each do |protected_file|
  fail("#{protected_file} file shouldn't be deleted or renamed") if git.deleted_files.include?(protected_file) || git.renamed_files.include?(protected_file)
end

# Fails when a dangerous 
[
  '.ruby-version',
  'Gemfile.lock',
].each do |protected_file|
  fail("#{protected_file} file shouldn't be deleted or renamed") if git.deleted_files.include?(protected_file) || git.renamed_files.include?(protected_file)
end
# TODO: check that bundle install where ran