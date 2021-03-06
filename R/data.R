#' Treatments
#'
#' Dataset of treatments for EGFR positive NSCLC.
#'
#' @format A data.table object with one row for each available treatment and with
#' columns:
#' \describe{
#'   \item{tx_name}{Name of treatment.}
#'   \item{tx_abb}{Abbreviation for the treatment.}
#'   \item{route}{Route of administration.}
#'   \item{approval_yr}{Year that treatment was approved in the US by the Federal Drug Administration (FDA)}
#'   \item{yrs_since_approval}{Years (from the last update of the model) since the treatment was approved.}
#' }
#' @examples 
#' print(treatments)
"treatments"

#' Patient age
#'
#' Distribution of patient ages.
#'
#' @format A \code{data.table} with columns:
#' \describe{
#'   \item{age_cat}{Age category.}
#'   \item{age_lower}{Lower bound of age category.}
#'   \item{age_upper}{Upper bound of age category.}
#'   \item{age_mid}{Midpoint of age category.}
#'   \item{prop}{Proportion of patients in age category.}
#' }
#' Also contains the attributes:
#' \describe{
#' \item{mean}{Mean age.}
#' \item{sd}{Standard deviation of age.}
#' } 
#' @source {\url{https://seer.cancer.gov/csr/1975_2015/results_merged/topic_age_dist.pdf}}
#'
#' @examples 
#' print(age_dist)
#' attr(age_dist, "mean")
#' attr(age_dist, "sd")
"age_dist"

#' Multi-state network meta-analysis parameters
#'
#' Posterior distributions of the regression coefficients of the continuous 
#' time state transition model estimated using the multi-state network meta-analysis. 
#'
#' @format A list of \code{\link[hesim]{params_surv}} objects from the 
#' \href{https://innovationvalueinitiative.github.io/hesim/}{hesim} package
#' package. The list contains regression coefficient estimates from the Weibull,
#' Gompertz, and 2nd order fractional polynomial survival distributions. The 
#' parameter (e.g., scale and shape for the Weibull distribution) of each survival 
#' distribution are predicted as a function of treatments, health state transitions, and
#' treatment history (for 2L treatments).
"params_mstate_nma"

#' Adverse events
#'
#' Dataset of adverse events included in the model.
#'
#' @format A data.table object with one row for each adverse event and with
#' columns:
#' \describe{
#'   \item{ae_name}{Name of adverse event.}
#'   \item{ae_abb}{Abbreviation for the adverse event.}
#' }
#' @examples 
#' print(adverse_events)
"adverse_events"

#' Adverse event network meta-analysis parameters
#'
#' The posterior distribution of the probability of an adverse event by available
#' first and second line treatments. Based on separate models by adverse event 
#' with a binomial likelihood and a logit link.
#'
#' @format A list where each element is a matrix for a distinct adverse event.
#' Each column is a distinct treatment and each row is a random draw from
#' the posterior distribution. Each matrix contains a "imputed" attribute, which
#' is vector of 0's and 1's with length equal to the number of columns, and a 1
#' denotes whether values of a column have been imputed because of insufficient
#' clinical trial data.
#' 
#'  When there is missing data for a TKI for a given adverse 
#' event, it is assumed to have the same adverse event probabilities as the TKI 
#' (among the TKI's with data) with the highest mean adverse event probability. When there
#' is missing data for a combination therapy containing PBDC, it is assumed to have
#' the same adverse event probabilities as PBDC. Finally, when there is not data for
#' any PBDC based therapy, all PBDC based therapies are assumed to have the same
#' adverse event probabilities as the TKI with the highest mean adverse event probability.
#' @examples 
#' names(params_ae_nma)
#' head(params_ae_nma[[1]])
#' attr(params_ae_nma[[1]], "imputed")
"params_ae_nma"

#' Utility parameters
#'
#' Utility estimates by health state and disutilities by adverse event.
#'
#' @format A list containing the following elements:
#' \itemize{
#' \item{state_utility}{ Utility estimates by health state.}
#' \item{as_disutility}{ Disutility by health state.}
#' }
#' 
#' @section State utility:
#' The \code{state_utility} element is a data table with the following columns:
#' \describe{
#' \item{state_name}{Name of the health state.}
#' \item{mean}{Mean utility.}
#' \item{se}{Standard error of utility.}
#' \item{ref}{BibTeX reference for estimate.}
#' }
#' 
#' @section Adverse event disutilities:
#' The \code{as_disutility} element is a data table with the following columns:
#' \describe{
#' \item{ae_name}{Name of the adverse event.}
#' \item{ae_abb}{Abbreviation for the adverse event.}
#' \item{mean}{Mean disutility.}
#' \item{se}{Standard error of disutility.}
#' \item{ref}{BibTeX reference for estimate.}
#' }
#' @examples 
#' print(params_utility)
"params_utility"

#' Treatment cost parameters
#'
#' Information on dosage, strength, pricing, and administration costs needed
#' to estimate costs of treatments sequences.
#'
#' @format A list with the following elements:
#' 
#' @section dosage:
#' A \code{data.table} containing information on dosage for each
#' agent used for treatments that can be included in a treatment sequence. The variables
#' \code{strength1}, \code{strength2}, \code{quantity1}, \code{quantity2}, \code{units_per_day},
#' and \code{duration_days} can be modified to change annualized costs. 
#' \describe{
#' \item{agent_name}{Name of the agent used in the treatment; combination therapies will have
#' more than one agents.}
#' \item{dosage}{Amount, number. and frequency of doses over a specified time period.}
#' \item{dose}{Specified amount of medication taken at one time. By default, doses
#' based on body surface area (BSA) and weight are based on mean BSA and weight,
#' respectively.}
#' \item{unit}{The unit used to compute costs.}
#' \item{strength1}{The amount of the drug in a single dosage form (e.g., tablet or vial).}
#' \item{strength2}{If a unit consists of multiple dosage forms, then the amount of the drug
#' in the dosage form not included in \code{strength1}.}
#' \item{quantity1}{Quantity of dosage form specified in \code{strength1} in a unit.}
#' \item{quantity2}{Quantity of dosage form specified in \code{strength2} in a unit.}
#' \item{units_per_day}{Number of units of the treatment (based on dosage) used per day.}
#' \item{duration_days}{Number of days to use the treatment. If used until progression, then 
#' must equal \code{Inf}.}
#' \item{source}{Source for dosage information.}
#' }
#' 
#' @section acquisition_costs:
#' A \code{data.table} of acquisition costs by \code{agent} and \code{strength}.
#' Default costs are based on wholesale acquisition costs (WACs). The variable 
#' \code{acquisition_cost} can be modified to change annualized acquisition costs.
#' \describe{
#' \item{agent_name}{Name of the agent}
#' \item{strength}{The amount of the agent in a given unit of the dosage form.}
#' \item{acquisition_cost}{The acquisition cost of an \code{agent} for a given \code{strength}.}
#' \item{source}{Source used for \code{acquisition cost}.}
#' }
#' 
#' @section discounts:
#' \describe{
#'  \item{agent_name}{Name of the agent.}
#'  \item{discount_lower}{Lower bound for discount and rebates as a 
#'  proportion of \code{acquisition_cost} in the \code{acquisition_costs} table.
#'   Assumed to follow a uniform distribution in the probabilistic sensitivity analysis.}
#'  \item{discount_upper}{Upper bound for discount and rebates as a 
#'  proportion of \code{acquisition_cost} in the \code{acquisition_costs} table.
#'   Assumed to follow a uniform distribution in the probabilistic sensitivity analysis.}
#' }
#' 
#' @section administration_costs:
#' A \code{data.table} of administration costs. The variable \code{costs}
#' can be modified to change annualized administration costs.
#' \describe{
#' \item{agent_name}{Name of the agent.}
#' \item{administration_cost}{The costs of administering an agent. }
#' \item{source}{Source used for \code{administration cost}.}
#' }
#' 
#' @section lookup:
#' A lookup \code{data.table} used to match treatments from the \code{\link{treatments}}
#' table to agents comprising a particular treatment.
#' \describe{
#' \item{tx_name}{Name of treatment.}
#' \item{agent_name1}{Name of first agent used for treatment.}
#' \item{agent_name2}{Name of second agent used for treatment.}
#' \item{agent_name3}{Name of third agent used for treatment.}
#' \item{agent_name4}{Name of fourth agent used for treatment.}
#' } 
#' 
#' 
#' @examples 
#' print(params_costs_tx)
"params_costs_tx"

#' Outpatient cost parameters
#'
#' Mean monthly outpatient costs by health state.
#'
#' @format A data table with the following columns:
#' \describe{
#' \item{state_name}{Name of the health state.}
#' \item{mean}{Mean outpatient costs.}
#' \item{se}{Standard error of outpatient costs.}
#' \item{ref}{BibTeX reference for estimate.}
#' }
#' @examples 
#' print(params_costs_op)
"params_costs_op"

#' Inpatient cost parameters
#'
#' Mean monthly inpatient costs by health state.
#'
#' @format A data table with the following columns:
#' \describe{
#' \item{state_name}{Name of the health state.}
#' \item{mean}{Mean outpatient costs.}
#' \item{se}{Standard error of outpatient costs.}
#' \item{ref}{BibTeX reference for estimate.}
#' }
#' @examples 
#' print(params_costs_inpt)
"params_costs_inpt"

#' Adverse event cost parameters
#'
#' Mean costs by adverse event. Note that only the \code{mean} and \code{se} 
#' columns in the table below are used for the probabilistic sensitivity analysis.
#'
#' @format A data table with the following columns:
#' \describe{
#' \item{ae_name}{Name of the adverse event.}
#' \item{ae_abb}{Abbreviation for the adverse event.}
#' \item{mean}{Mean costs.}
#' \item{lower}{2.5\% quantile for mean costs.}
#' \item{upper}{97.5\% quantile for mean costs.}
#' \item{se}{Standard error of costs.}
#' \item{ref}{Reference for mean costs.}
#' }
#' @examples 
#' print(params_costs_ae)
"params_costs_ae"

#' Productivity cost parameters
#'
#' Parameters used to estimate productivity costs including costs from 
#' temporary disability, permanent disability, and premature mortality. 
#' 
#' @format A list with the following elements:
#' 
#' @section wages:
#' A \code{data.table} with columns:
#' \describe{
#' \item{gender}{Male or female gender.}
#' \item{employment_status}{Employed full-time, employed part-time, or unemployed.}
#' \item{prop}{Proportion of population.}
#' \item{weekly_wage}{Weekly wage.}
#' \item{source_prop}{Source for \code{prop}.}
#' \item{source_wage}{Source for \code{wage}.}
#' }
#' Mean wages are computed as a weighted average of wages for full-time,
#' part-time, and unemployed workers. 
#' 
#' @section temporary_disability:
#' A vector with three elements:
#' \describe{
#' \item{missed_days_est}{Estimate for number of days worked following diagnosis 
#' due to sick leave and leave of absence.}
#' \item{missed_days_lower}{Lower bound for \code{missed_days_est}.}
#' \item{missed_days_upper}{Upper bound for \code{missed_days_upper}.}
#' }
#' 
#' @section permanent_disability:
#' A vector with three elements:
#' \describe{
#' \item{hours_reduction_est}{Estimate of reduced working hours following initial abscence.}
#' \item{hours_reduction_lower}{Lower bound for \code{hours_reduction_est}.}
#' \item{hours_reduction_upper}{Upper bound for \code{hours_reduction_est}.}
#' } 
#' 
#' @examples 
#' print(params_costs_prod)
"params_costs_prod"

#' MCDA defaults
#'
#' Default values used in web applications for multi-criteria decision-analysis.
#'
#' @format A list of two data tables, one for the three state model and
#' another for the four state model. Each table contains the following columns:
#' \describe{
#' \item{criteria_name}{Name of the criteria.}
#' \item{weight}{Weights to apply to each criteria.}
#' \item{min}{Minimum value for the criteria (i.e., lowest possible performance).}
#' \item{max}{Maximum value for the criteria (i.e., highest possible performance).}
#' }
#' @seealso \code{\link{mcda}}
#' @examples 
#' print(mcda_defaults)
"mcda_defaults"

#' Progression-free survival and overall survival from network meta-analysis
#'
#' Curves of progression-free survival (PFS) and overall survival (OS) 
#' estimated using a Bayesian multi-state network meta-analyis (NMA). PFS is 
#' the duration of time a patient is alive without disease 
#' progression and OS is the duration of a time a patient is alive.
#'
#' @format A data.table with the following columns:
#' \describe{
#'   \item{line}{Line of treatment. Either first or second.}
#'   \item{mutation}{At 2nd line, equal to 1 if there is a T790M mutation and 
#'   0 otherwise.}
#'   \item{model}{The statistical model.} 
#'   \item{tx_name}{Name of the treatment.}
#'   \item{month}{Trial month.}
#'   \item{mean}{Mean PFS/OS from the posterior distribution.}
#'   \item{median}{Median PFS/OS from the posterior distribution.}
#'   \item{l95}{Lower limit of 95 percent credible interval from posterior distribution.}
#'   \item{u95}{Upper limit of the 95 percent credible interval from the posterior distribution.}
#' }
#' @examples 
#' head(mstate_nma_pfs)
#' head(mstate_nma_os)
#' @seealso \code{\link{mstate_nma_hazard}},  \code{\link{mstate_nma_hr}}
#' @name mstate_nma_surv
NULL

#' @rdname mstate_nma_surv
"mstate_nma_pfs"

#'@rdname mstate_nma_surv
"mstate_nma_os"

#' Hazard functions from network meta-analysis
#'
#' Hazard functions for each health state transition
#' estimated using a Bayesian multi-state network meta-analyis (NMA).
#'
#' @format A data.table with the following columns:
#' \describe{
#'   \item{line}{Line of treatment. Either first or second.}
#'   \item{mutation}{At 2nd line, equal to 1 if there is a T790M mutation and 
#'   0 otherwise.}
#'   \item{model}{The statistical model.} 
#'   \item{tx_name}{Name of the treatment.}
#'   \item{month}{Trial month.}
#'   \item{transition}{The health state transition.}
#'   \item{mean}{Mean hazard from the posterior distribution.}
#'   \item{median}{Median hazard from the posterior distribution.}
#'   \item{l95}{Lower limit of 95 percent credible interval from posterior distribution.}
#'   \item{u95}{Upper limit of the 95 percent credible interval from the posterior distribution.}
#' }
#' @examples 
#' head(mstate_nma_hazard)
#' @seealso \code{\link{mstate_nma_surv}},  \code{\link{mstate_nma_hr}}
"mstate_nma_hazard"

#' Hazard ratios from network meta-analysis
#'
#' Hazard ratios for first line treatments relative to gefitinib
#' estimated using a Bayesian multi-state network meta-analyis (NMA).
#'
#' @format A data.table with the following columns:
#' \describe{
#'   \item{line}{Line of treatment. Either first or second.}
#'   \item{model}{The statistical model.} 
#'   \item{tx_name}{Name of the treatment.}
#'   \item{month}{Trial month.}
#'   \item{transition}{The health state transition.}
#'   \item{mean}{Mean hazard ratio from the posterior distribution.}
#'   \item{median}{Median hazard ratio from the posterior distribution.}
#'   \item{l95}{Lower limit of 95 percent credible interval from posterior distribution.}
#'   \item{u95}{Upper limit of the 95 percent credible interval from the posterior distribution.}
#' }
#' @examples 
#' head(mstate_nma_hr)
#' @seealso \code{\link{mstate_nma_surv}}, \code{\link{mstate_nma_hazard}}
"mstate_nma_hr"

#' Coefficients from network meta-analysis
#'
#' Coefficients for first line treatments relative to gefitinib
#' estimated using a Bayesian multi-state network meta-analyis (NMA).
#'
#' @format A data.table with the following columns:
#' \describe{
#'   \item{line}{Line of treatment. Either first or second.}
#'   \item{model}{The statistical model.} 
#'   \item{tx_name}{Name of the treatment.}
#'   \item{transition}{The health state transition.}
#'   \item{coef}{Coefficient as outlined mathematically in the 
#'                   PDF model documentation.}
#'   \item{q0.025}{2.5th percentile of the posterior distribution.}
#'   \item{q0.25}{25th percentile of the posterior distribution.}
#'   \item{q0.5}{50th percentile of the posterior distribution.}
#'   \item{q0.75}{75th percentile of the posterior distribution.}
#'   \item{q0.90}{90th percentile of the posterior distribution.}
#' }
#' @seealso \code{\link{mstate_ma_coef}}
#' @examples 
#' print(mstate_nma_coef)
"mstate_nma_coef"

#' Coefficients from meta-analyses
#'
#' Coefficients for first and second line absolute effects estimated using
#' Bayesian meta-analyes (MAs).
#'
#' @format A data.table with the following columns:
#' \describe{
#'   \item{line}{Line of treatment. Either first or second.}
#'   \item{mutation}{At 2nd line, equal to 1 if there is a T790M mutation and 
#'   0 otherwise.}
#'   \item{model}{The statistical model.} 
#'   \item{tx_name}{Name of the treatment.}
#'   \item{transition}{The health state transition.}
#'   \item{coef}{Coefficient as outlined mathematically in the 
#'                   PDF model documentation.}
#'   \item{q0.025}{2.5th percentile of the posterior distribution.}
#'   \item{q0.25}{25th percentile of the posterior distribution.}
#'   \item{q0.5}{50th percentile of the posterior distribution.}
#'   \item{q0.75}{75th percentile of the posterior distribution.}
#'   \item{q0.90}{90th percentile of the posterior distribution.}
#' }
#' @seealso \code{\link{mstate_nma_coef}}
#' @examples 
#' print(mstate_ma_coef)
"mstate_ma_coef"