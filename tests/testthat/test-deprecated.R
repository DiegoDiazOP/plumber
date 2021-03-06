context("Deprecated")

test_that("addEndpoint continues to work", {
  pr <- plumber$new()
  expect_warning(pr$addEndpoint("GET", "/", function(){ 123 }))
  expect_error(expect_warning(pr$addEndpoint("GET", "/", function(){ 123 }, comments="break")))

  val <- pr$route(make_req("GET", "/"), PlumberResponse$new())
  expect_equal(val, 123)
})

test_that("addFilter continues to work", {
  pr <- plumber$new()
  expect_warning(pr$addFilter("f1", function(req){ req$filtered <- TRUE }))
  pr$handle("GET", "/", function(req){ req$filtered })

  val <- pr$route(make_req("GET", "/"), PlumberResponse$new())
  expect_true(val)
})

test_that("addGlobalProcessor continues to work", {
  pr <- plumber$new()
  expect_warning(pr$addGlobalProcessor(sessionCookie("secret", "cookieName")))
})

test_that("addAssets continues to work", {
  pr <- plumber$new()
  expect_warning(pr$addAssets(test_path("./files/static"), "/public"))
  res <- PlumberResponse$new()
  val <- pr$route(make_req("GET", "/public/test.txt"), res)
  expect_true(inherits(val, "PlumberResponse"))
})
