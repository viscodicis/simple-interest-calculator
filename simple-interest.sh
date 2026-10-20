#!/usr/bin/env bash
set -euo pipefail

# Simple Interest Calculator
# Formula: simple interest = principal * annual rate * time in years / 100

is_number() {
  awk -v value="$1" 'BEGIN { exit !(value ~ /^([0-9]+([.][0-9]*)?|[.][0-9]+)$/) }'
}

is_greater_than_zero() {
  awk -v value="$1" 'BEGIN { exit !(value > 0) }'
}

printf '%s\n' "Simple Interest Calculator"
printf '%s\n' "Enter the principal, annual interest rate (percent), and time in years."

read -r -p "Principal amount: " principal
while ! is_number "$principal" || ! is_greater_than_zero "$principal"; do
  printf '%s\n' "Please enter a positive number for the principal."
  read -r -p "Principal amount: " principal
done

read -r -p "Annual interest rate (%): " rate
while ! is_number "$rate"; do
  printf '%s\n' "Please enter a non-negative number for the interest rate."
  read -r -p "Annual interest rate (%): " rate
done

read -r -p "Time (years): " time
while ! is_number "$time" || ! is_greater_than_zero "$time"; do
  printf '%s\n' "Please enter a positive number for the time period."
  read -r -p "Time (years): " time
done

read -r simple_interest total_amount < <(
  awk -v principal="$principal" -v rate="$rate" -v time="$time" \
    'BEGIN {
      interest = principal * rate * time / 100
      printf "%.2f %.2f\n", interest, principal + interest
    }'
)

printf '\nSimple interest: %s\n' "$simple_interest"
printf 'Total amount (principal + interest): %s\n' "$total_amount"
