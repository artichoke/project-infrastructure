output "branch_href" {
  description = "Link to the newly-created branch"
  value = join("/", [
    "https://github.com",
    var.organization,
    var.repository,
    "tree",
    replace(github_branch.pr_target.ref, "refs/heads/", ""),
  ])
}
