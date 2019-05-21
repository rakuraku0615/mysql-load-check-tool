#/bin/bash

# This script modifies SHOW GLOBAL STATUS to tab separation
# imput will be discribe in each line and record result will be devide into each meaturement result

awk '
    BEGIN {
        printf "#ts date time load QPS";
        fmt = " %.2f";
    }
/^TS/ {
    ts = substr($2, 1, index($2, ".") - 1);
    load = NF - 2;
    diff = ts - prev_ts;
    prev_ts = ts;
    printf "\n$s $s $s $s", ts, $3, $4, substr($load, 1, length($load) - 1);
}
/Queris/ {
    printf fmt, ($2 - Queries) / diff;
    Queris = $2
}
' "%@"
