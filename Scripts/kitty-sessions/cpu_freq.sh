#!/usr/bin/env bash

CPU=$(cat /proc/cpuinfo | grep -m 1 'model name' | sed -e 's/[^:]*: //')
MAX_CPU_FREQ=()
MIN_CPU_FREQ=()

while true; do
    RAW=$(cat /proc/cpuinfo | grep 'MHz' | sed -e 's/[^:]*: //' -e 's/\..*//' | tr "\n" ",")
    IFS=',' read -ra CPU_FREQ <<< $RAW
    # IFS=',' read -ra SENSOR <<< $(sensors | grep -A11 'zenpower' | tr "\n" ",")
    
    if [ ${#MAX_CPU_FREQ[@]} -eq 0 ]; then
        for i in "${!CPU_FREQ[@]}"; do
            MAX_CPU_FREQ+=(${CPU_FREQ[$i]})
            MIN_CPU_FREQ+=(${CPU_FREQ[$i]})
        done
    else
        for i in "${!CPU_FREQ[@]}"; do
            if [ $((MAX_CPU_FREQ[$i] - CPU_FREQ[$i])) -lt 0 ]; then
                MAX_CPU_FREQ[$i]=${CPU_FREQ[$i]}
            fi
            if [ $((MIN_CPU_FREQ[$i] - CPU_FREQ[$i])) -gt 0 ]; then
                MIN_CPU_FREQ[$i]=${CPU_FREQ[$i]}
            fi
        done
    fi

    SENSOR="$(sensors | grep -A11 'zenpower' | tail -10)"
    HALF=$(((${#CPU_FREQ[@]} + 1) / 2))
    tput reset
    printf "CPU: $CPU\n"
    printf "Core\tFreq Min  Max  | Core\tFreq Min  Max\n"
    for i in $(seq 0 "$((HALF - 1))"); do
        printf "%s\t%s %s %s | %s\t%s %s %s\n" \
            "$i" \
            "${CPU_FREQ[$i]}" \
            "${MIN_CPU_FREQ[$i]}" \
            "${MAX_CPU_FREQ[$i]}" \
            "$((i+HALF))" \
            "${CPU_FREQ[$((i+HALF))]}" \
            "${MIN_CPU_FREQ[$((i+HALF))]}" \
            "${MAX_CPU_FREQ[$((i+HALF))]}"
    done

    echo -e "$SENSOR"

    sleep 0.1
done

