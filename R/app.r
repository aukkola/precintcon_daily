#' @name app
#' @aliases app
#' @author Lucas Venezian Povoa \email{lucasvenez@@gmail.com}
#' 
#' @title Amount and Percentage of Precipitation
#' @description It calculates the amount and percentage of precipitation contributed by a such percent of rainiest days.
#' @usage app(..., percent = 25)
#' @param \dots a set of daily precipitation series.
#' @param percent is the percentage of the rainiest days to be considered (default = 25).
#' @return  data.frame containing the following variables:
#' \itemize{
#' \item \code{dataset} is the dataset name of the precipitation serie;
#' \item \code{percentage} is the percentage of the rainiest days;
#' \item \code{absolute} is the absolute amount of precipitation generated by \code{percentage}% of the rainiest days; and
#' \item \code{relative} is the percentage of precipitation benerated by \code{percentage}% of the rainiest days.
#' }
#' @examples
#' data(daily) 
#' 
#' app(daily)
#' 
#' app(daily, percent = 20)
#' 
#' app(daily, percent = c(10, 15, 20, 25))
#' @seealso
#' \code{\link{read.data}}
#' \code{\link{as.daily}}
#' \code{\link{ci}}
#' @export 
app <- function(..., percent = 25) {

  l <- list(...)
  
  pars <- as.list(as.character(as.list(match.call()[1:length(l)+1])))
  
  if (length(l) > 0) {
    
    set <- NULL
    
    pars <- as.character(match.call()[1:length(l)+1])
    
    for (j in 1:length(pars)) {
      
      res <- lapply(l, function(object, p, d) {
        
        ##
        # Percentage of rain in the 25% rainest days
        v <- as.vector(as.matrix(object[-(1:2)]))
        
        total <- c()
        perc  <- c()
        
        for (i in 1:length(p)) {
          total[i] <- sum(tail(sort(v), n = (p[i]/100) * length(v)), na.rm = T)
          perc[i]  <- total[i] / sum(v, na.rm = T)
        }
        
        return(data.frame(dataset = d, percentage = p, absolute = total, relative = perc))
        
      }, percent, pars[j])
    }
    
    do.call(rbind.data.frame, res)
  }
}