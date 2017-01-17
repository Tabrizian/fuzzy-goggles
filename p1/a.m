function weather = forecast(p, n, initial)
    if(n == 1)
        weather = initial * p
    else
        weather = forecast(p, n - 1, initial) * p
    endif

endfunction
