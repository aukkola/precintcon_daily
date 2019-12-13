#' @include as.precintcon.daily.r
NULL

#' @name as.daily
#' @author Lucas Venezian Povoa \email{lucasvenez@@gmail.com}
#' @aliases as.precintcon.daily as.daily
#' 
#' @title Converting a data.frame to a daily precipitation serie
#' @description Converts a \code{data.frame} to a \code{precintcon.daily}.
#' @param object a precintcon.daily or a data.frame containing 33 columns.
#' @param na.value the value used for representing non-existent values
#' (Default value: NA).
#' @usage as.daily(object, na.value = NA)
#' @return A \code{data.frame} (\code{precintcon.daily}) containing the 
#' following variables:
#' \itemize{
#' \item \code{year} is the year.
#' \item \code{day} is the day.
#' \item \code{d1} is the precipitation value in millimeters of the each day
#' 
#' }
#' @seealso 
#' \code{\link{as.decade}}
#' \code{\link{as.annual}}
#' \code{\link{as.seasonal}}
#' \code{\link{as.monthly}} 
#' @usage as.daily(object, na.value = NA)
#' @examples
#' ##
#' # Loading the daily precipitation serie.
#' data(daily)
#' 
#' ##
#' # Converting precipitation
#' as.daily(daily)
#' @keywords daily precipitation
#' @export
as.daily <- function(object, na.value = NA) {
  return(as.precintcon.daily(object, na.value))
}