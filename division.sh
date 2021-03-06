#!/bin/bash

function division()
{
first_num=`echo "$1" | cut -f1 -d/`
second_num=`echo "$1" | cut -f2 -d/`
if [[ $1  == *"."* ]]; then
   if [[ $first_num == *"."* ]]; then
      first_num_dat_first=`echo "$first_num" | cut -f1 -d.`
      first_num_dat_second=`echo "$first_num" |cut -f2 -d.`
      first_num_dat=`echo -n $first_num_dat_second |wc -c`  
      first_num_after=$((($first_num_dat_first*10**($first_num_dat))+$first_num_dat_second))
      #Float the first and second numbers
      if [[ $second_num == *"."* ]]; then
         second_num_dat_first=`echo "$second_num" | cut -f1 -d.`
         second_num_dat_second=`echo "$second_num" |cut -f2 -d.`
         second_num_dat=`echo -n $second_num_dat_second |wc -c` 
         #Define by what degree to multiply
         if [[ $first_num_dat -ge $second_num_dat ]]; then
            second_num_after=$((($second_num_dat_first*10**($first_num_dat))+$second_num_dat_second*10**($first_num_dat-$second_num_dat)))
            printf %.3f "$((10**3 * $first_num_after/$second_num_after))e-3"
            echo " "
            exit 0
         else
            first_num_after=$((($first_num_dat_first*10**($second_num_dat))+$first_num_dat_second*10**($second_num_dat-$first_num_dat)))
            second_num_after=$((($second_num_dat_first*10**($second_num_dat))+$second_num_dat_second))
            printf %.3f "$((10**3 * $first_num_after/$second_num_after))e-3"
            echo " "
            exit 0
         fi
      #Float the first number only
      else
         second_num_comp=$(($second_num*10**$first_num_dat))
         printf %.3f "$((10**3 * $first_num_after/$second_num_comp))e-3"
         echo " "
         exit 0
      fi
   #Float point the second number only
   else
      second_num_dat_first=`echo "$second_num" | cut -f1 -d.`
      second_num_dat_second=`echo "$second_num" |cut -f2 -d.`
      second_num_dat=`echo -n $second_num_dat_second |wc -c`
      second_num_after=$((($second_num_dat_first*10**($second_num_dat))+$second_num_dat_second))
      first_num_comp=$(($first_num*10**$second_num_dat))
      printf %.3f "$((10**3 * $first_num_comp/$second_num_after))e-3"
      echo " "
      exit 0
   fi
#Both numbers integers
else
   printf %.3f "$((10**3 * $1))e-3"
   echo " "
   exit 0
fi
}
