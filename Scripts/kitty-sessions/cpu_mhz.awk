BEGIN {
    max=0
} { 
    sum+=$4
    n++
    str = sprintf("%s%s%s",str,(n % 2 == 0) ? " | " : "\n",$0)
    if ($4>max) max=$4
} END {
    if (n > 0) print "Avg " sum / n " MHz";
    print "Max "max" MHz";
    gsub("cpu", "CPU", str)
    gsub("\t\t", "", str)
    print str
}
