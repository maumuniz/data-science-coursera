cacheSolve <- function(x, ...) {
  xInv <- x$getInv()
  if(!is.null(xInv)) {
    message("getting cached data")
    return(xInv)
  }
  data <- x$get()
  xInv <- solve(data, ...)
  x$setInv(xInv)
  xInv
}