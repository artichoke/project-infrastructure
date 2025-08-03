output "redirects" {
  value = [
    for pages in module.github_pages : {
      domains = pages.domains,
    }
  ]
}
