module StudentLoan

include("smartoptionloan.jl")
export 
    InterestOnlyLoan, 
    FixedRepaymentLoan, 
    DeferredRepaymentLoan,
    generatecashflow,
    pre_deferment_principal

end # module StudentLoan
