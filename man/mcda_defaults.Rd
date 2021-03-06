% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/data.R
\docType{data}
\name{mcda_defaults}
\alias{mcda_defaults}
\title{MCDA defaults}
\format{A list of two data tables, one for the three state model and
another for the four state model. Each table contains the following columns:
\describe{
\item{criteria_name}{Name of the criteria.}
\item{weight}{Weights to apply to each criteria.}
\item{min}{Minimum value for the criteria (i.e., lowest possible performance).}
\item{max}{Maximum value for the criteria (i.e., highest possible performance).}
}}
\usage{
mcda_defaults
}
\description{
Default values used in web applications for multi-criteria decision-analysis.
}
\examples{
print(mcda_defaults)
}
\seealso{
\code{\link{mcda}}
}
\keyword{datasets}
