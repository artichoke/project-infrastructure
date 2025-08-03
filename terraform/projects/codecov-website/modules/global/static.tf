resource "aws_s3_object" "robots" {
  bucket = aws_s3_bucket.this.id
  key    = "robots.txt"
  source = "${path.module}/static/robots.txt"

  etag         = filemd5("${path.module}/static/robots.txt")
  content_type = "text/plain"

  server_side_encryption = "AES256"
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.this.id
  key    = "index.html"
  source = "${path.module}/static/index.html"

  etag         = filemd5("${path.module}/static/index.html")
  content_type = "text/html"

  server_side_encryption = "AES256"
}

resource "aws_s3_object" "favicon" {
  for_each = {
    "png" = {
      path = "${path.module}/static/favicon-32x32.png",
      type = "image/png"
      name = "favicon-32x32.png"
    },
    "ico" = {
      path = "${path.module}/static/favicon.ico",
      type = "image/x-icon"
      name = "favicon.ico"
    },
  }

  bucket = aws_s3_bucket.this.id
  key    = each.value.name
  source = each.value.path

  etag         = filemd5(each.value.path)
  content_type = each.value.type

  server_side_encryption = "AES256"
}

# Upload Artichoke wordmark
resource "aws_s3_object" "brand_asset" {
  for_each = {
    "artichoke-logo" = "${path.module}/static/img/artichoke-logo.svg"
    "wordmark-color" = "${path.module}/static/img/wordmark-color.svg"
  }

  bucket = aws_s3_bucket.this.id
  key    = "img/${each.key}.svg"
  source = each.value

  etag         = filemd5(each.value)
  content_type = "image/svg+xml"

  server_side_encryption = "AES256"
}


# Font Awesome icons
resource "aws_s3_object" "icon" {
  for_each = {
    "code"          = "${path.module}/static/icons/code.svg",
    "file-code"     = "${path.module}/static/icons/file-code.svg",
    "github"        = "${path.module}/static/icons/github.svg",
    "list"          = "${path.module}/static/icons/list.svg",
    "square-github" = "${path.module}/static/icons/square-github.svg",
  }

  bucket = aws_s3_bucket.this.id
  key    = "icons/${each.key}.svg"
  source = each.value

  etag         = filemd5(each.value)
  content_type = "image/svg+xml"

  server_side_encryption = "AES256"
}

resource "aws_s3_object" "css" {
  for_each = {
    "global" = "${path.module}/static/global.css"
  }

  bucket = aws_s3_bucket.this.id
  key    = "${each.key}.css"
  source = each.value

  etag         = filemd5(each.value)
  content_type = "text/css"

  server_side_encryption = "AES256"
}
