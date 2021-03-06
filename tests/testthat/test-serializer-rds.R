context("rds serializer")

test_that("rds serializes properly", {
  v <- iris[0,]
  attr(v, "origin") <- iris
  val <- serializer_rds()(v, list(), PlumberResponse$new(), stop)
  expect_equal(val$status, 200L)
  expect_equal(val$headers$`Content-Type`, "application/octet-stream")
  expect_equal(val$body, serialize(v, NULL, ascii = FALSE))
  expect_equal(unserialize(val$body), v)
})
