makeCacheMatrix <- function(x = matrix()) {
  invX <- NULL
  set <- function(y) {
    x <<- y
    invX <<- NULL
  }
  get <- function() x
  setInv <- function(iX) invX <<- iX
  getInv <- function() invX
  list(set = set, get = get,
       setInv = setInv,
       getInv = getInv)
}