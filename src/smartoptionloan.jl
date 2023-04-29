import Dates: Date, Month
import Base.display
import TimeSeries: TimeArray


abstract type AbstractLoan end
abstract type AbstractSmartOptionLoan <: AbstractLoan end

struct InterestOnlyLoan <: AbstractSmartOptionLoan
    borrowerid::String
    originationdate::Date
    p_and_i_repaymentdate::Date
    amount::Union{Float64, Int64}
    interestrate::Union{Float64, Int64}
    term::Integer
    deferment_period::Integer
    io_period::Integer
end


struct DeferredRepaymentLoan <: AbstractSmartOptionLoan
    borrowerid::String
    originationdate::Date
    amount::Union{Float64, Int64}
    interestrate::Union{Float64, Int64}
    term::Integer
    deferment_period::Integer
end

struct FixedRepaymentLoan <: AbstractSmartOptionLoan
    borrowerid::String
    originationdate::Date
    amount::Union{Float64, Int64}
    interestrate::Union{Float64, Int64}
    term::Integer
    deferment_period::Integer
    fixed_pmt::Union{Float64, Int64}
end

function display(p::AbstractSmartOptionLoan)
    println("Borrower: ", p.borrowerid, " (amount: ", p.amount, ")")
end

function display(p::InterestOnlyLoan)
    println("Borrower: ", p.borrowerid, " (amount: ", p.amount, ", io_period: ", p.io_period, ")")
end

function display(p::DeferredRepaymentLoan)
    println("Borrower: ", p.borrowerid, " (amount: ", p.amount, ", deferment_period: ", p.deferment_period, ")")
end

function display(p::FixedRepaymentLoan)
    println("Borrower: ", p.borrowerid, " (amount: ", p.amount, ", fixed pmt: ", p.fixed_pmt, ")")
end


function generatecashflow(loan::InterestOnlyLoan)

end

function generatecashflow(loan::FixedRepaymentLoan)

end

function generatecashflow(loan::DeferredRepaymentLoan)
    dates = loan.originationdate:Month(1):(loan.originationdate + Month(loan.term))
    
    deferment_end_date = loan.originationdate + Month(loan.deferment_period)
    cf_mat = zeros(length(dates), 3)

    cf_bal = loan.amount
    for (v, d) in enumerate(dates)
        if d <= deferment_end_date
            cf_int = cf_bal * loan.interestrate/12.0
            cf_prn = 0 - cf_int
            cf_bal -= cf_prn
        else 
            if d == deferment_end_date + Month(1)
                global pmt = genpmt(cf_bal, loan.interestrate, (loan.term - loan.deferment_period))
            end
            cf_int = cf_bal * loan.interestrate/12.0
            cf_prn = pmt - cf_int
            cf_bal -= cf_prn
        end
        cf_mat[v, 1] = cf_int
        cf_mat[v, 2] = cf_prn
        cf_mat[v, 3] = cf_bal
    end
    ta = TimeArray(dates, cf_mat, [:interest, :principal, :balance])
    return ta
end

function genpmt(amount::AbstractFloat, interestrate::AbstractFloat, term::Integer)
    one_plus_r_n = (1.0 + interestrate/12)^term
    numer = amount * (interestrate/12) * one_plus_r_n
    denom = one_plus_r_n - 1.0
    return numer/denom
end