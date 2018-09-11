#' @export
precintcon.spi.analysis <- function(
   object, 
   period       = 3, 
   distribution = "Gamma"
) {
	
	d <- object
	
	if (distribution != "Gamma") {
	
		stop("there is no implementation for another distributions")
	
	} else if (is.element("precintcon.spi", class(d))) {
		
		return(d)
		
	} else if (is.element("precintcon.daily", class(d)) ||
			 is.element("precintcon.monthly", class(d))) {
		
		if (is.element("precintcon.daily", class(d)))
			d <- precintcon.monthly.aggregation(d)
		
		p <- c()
		
		for (j in 1:(nrow(d)-period+1)){
		  p <- c(p, sum(d[j:(period+j-1),3], na.rm=T))
		  if (any(is.na(d[j:(period+j-1),3]))) { p[length(p)] <- NA }

		}

		gamma_ <- precintcon.gamma(p, period)
		
		result <- data.frame()
		
		for (k in 1:length(p)) {
			
			m <- ((k + period - 1) %% 12) +1
			
			result <- 
				c(result, 
					precintcon.H( 
						gamma_[m,3], 
						gamma_[m,4], 
						gamma_[m,5], 
						p[k]))
		}
		
		result <- precintcon.Z(result)
		
		#This also fails if NA present, rewrite
		# if(any(result == -9.999000e+03)) {
		#   result[which(result == -9.999000e+03)] <- NA
		# }
		
		rm_ind <- which(result == -9.999000e+03)
		
		if(length(rm_ind) > 0) {
		  result[rm_ind] <- NA
		}
		
		d <- cbind(d[(if (period > 1) -(1:(period-1)) else 1:length(result)),1:2], result)
		
		colnames(d) <- c("year", "month", "spi")
		
		class(d) <- c("data.frame", "precintcon.spi")
		
		return(d)
		
	} else {
		stop("input data should be of type precintcon.daily or precintcon.monthly")
	}
};
