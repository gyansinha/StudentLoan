module StudentLoan

include("smartoptionloan.jl")
export 
    InterestOnlyLoan, 
    FixedRepaymentLoan, 
    DeferredRepaymentLoan,
    generatecashflow

end # module StudentLoan
