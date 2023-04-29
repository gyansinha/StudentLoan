import Dates: Date


struct SmartOptionLoan
    borrowerid::String
    originationdate::Date
    p_and_i_repaymentdate::Date
    amount::AbstractFloat
    interestrate::AbstractFloat
    term::Integer
end

struct InterestOnlyLoan
    loan::SmartOptionLoan
    interestonlyperiod::AbstractFloat
end

struct DeferredRepaymentLoan
    loan::SmartOptionLoan
    deferraldate::Date
end

struct FixedRepaymentLoan
    loan::SmartOptionLoan
    fixedrepaymentamount::AbstractFloat
end

function printloan(loan::SmartOptionLoan)
    println("I am a loan with borrowerid $(loan.borrowerid), \
        with an amount of $(loan.amount) \
        at a rate of $(loan.interestrate)% \
        for a term of $(loan.term) months.")
end

function generatecashflow(loan::InterestOnlyLoan)

end

function generatecashflow(loan::FixedRepaymentLoan)

end

function generatecashflow(loan::DeferredRepaymentLoan)
 
end