module StudentLoan

include("smartoptionloan.jl")
export 
    SmartOptionLoan,
    InterestOnlyLoan, 
    FixedRepaymentLoan, 
    DeferredRepaymentLoan,
    printloan,
    generatecashflow

end # module StudentLoan
