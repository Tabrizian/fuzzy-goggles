function weather = forecast(p, n, initial)
    if(n == 1)
        weather = initial * p;
    else
        weather = forecast(p, n - 1, initial) * p;
    endif

endfunction

today = [0, 1, 0];
p = [.4 .4 .2; .3 .3 .4; .1 .6 .3];
weather = forecast(p, 100, today)


