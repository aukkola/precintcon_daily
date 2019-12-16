#' @export
as.precintcon.daily <- function(object, na.value = NA) {

	if (!is.element("data.frame", class(object)) || ncol(object) != 3)
		stop("Invalid object. It must be a \"data.frame\" and contain 3 numeric columns.")
	
		# for (j in 1:nrow(object)) {
		# 	if (is.na(as.Date(paste(object[j,1], object[j,2], sep = "-"), "%Y-%d"))) {
		# 		a <- NA
		# 		object[j,3] <- a  
		# 	}
		# }

	
	colnames(object) <- c("year", "day", paste(rep("d", 1), 1, sep=""))
	
	class(object) <- c("data.frame", "precintcon.daily")
	
	return(object)
		
}
