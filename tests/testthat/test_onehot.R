
context('test onehot')


test_that('onehot returns a data.frame', {
  suppressWarnings(expect_s3_class(onehot(iris), 'data.frame'))
})


test_that('onehot returns a sparse matrix', {
  suppressWarnings(expect_s4_class(onehot(iris, sparse=TRUE), 'dgCMatrix'))
})

test_that('onehot will error if not supplied a data frame.', {
  suppressWarnings(expect_error(onehot(as.matrix(mtcars))))
})

test_that('onehot will error if not supplied a data frame.', {
  suppressWarnings(expect_error(onehot(as.matrix(mtcars))))
})

test_that('onehot will message if keep original and sparse if both true.', {
  suppressWarnings(expect_message(onehot(iris, keep.original = TRUE, sparse = TRUE)))
})

test_that('onehot will message if given numeric.', {
  suppressWarnings(expect_message(onehot(mtcars, var = 'cyl')))
})



iris2 = iris
iris2[sample(1:150, 25),] = NA
iris2$constant = TRUE

test_that('onehot will error no valid variables', {
  suppressWarnings(expect_error(onehot(iris2, var = 'constant')))
})

test_that('onehot correctly handles na.omit', {
  suppressWarnings(expect_equal(nrow(onehot(iris2, nas = 'na.omit')), nrow(iris) - 25))
})

test_that('onehot correctly handles na.exclude', {
  suppressWarnings(expect_equal(nrow(onehot(iris2, nas = 'na.exclude')), nrow(iris) - 25))
})

test_that('onehot correctly handles na.exclude', {
  suppressWarnings(expect_equal(nrow(onehot(iris2, nas = 'na.pass')), nrow(iris)))
})

test_that('onehot correctly handles na.fail', {
  suppressWarnings(expect_error(onehot(iris2, nas = 'na.fail')))
})

test_that('onehot correctly keeps original variable', {
  suppressWarnings(expect_equal(ncol(onehot(iris, keep.original = TRUE)), ncol(iris) + nlevels(iris$Species)))
})

test_that('onehot takes var argument', {
  suppressWarnings(expect_s3_class(onehot(iris, var = 'Species'), 'data.frame'))
})

test_that('onehot handles numbers', {
  suppressWarnings(expect_s3_class(onehot(mtcars, var = c('vs','cyl')), 'data.frame'))
})

test_that('onehot handles constant', {
  suppressWarnings(expect_error(onehot(iris2, var = 'constant')))
})
