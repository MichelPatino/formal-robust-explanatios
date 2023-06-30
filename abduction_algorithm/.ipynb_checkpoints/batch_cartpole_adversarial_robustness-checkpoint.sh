#!/bin/bash
#give permissions to file
#chmod u+x abduction_algorithm/batch_cartpole_adversarial_robustness.sh
#to execute:
#./abduction_algorithm/batch_cartpole_adversarial_robustness.sh

######################################################################
# Modifiable parameters

# add the benchmark name
benchmark_name="cartpole"

#perturbation size
epsilon=1.5

# the number of input variables of the model
number_of_input_variables=4

#define the root folder
root_folder="/root"

#results_folder
results_folder=$root_folder/"abduction_algorithm/results/adversarial_robustness_algorithm"


######################################################################
# Algorithm execution for a batch of instances

#create the results folder if it does not already exist
mkdir -p $results_folder

# create the csv file to store the results
python $root_folder/abduction_algorithm/python_scripts/create_csv.py $number_of_input_variables $benchmark_name $results_folder $epsilon 

#give permissions to access the new algorithm script
chmod u+x $root_folder/abduction_algorithm/adversarial_robustness_algorithm.sh

#change working directory
cd $root_folder/"abduction_algorithm/instances"/$benchmark_name

#get the file names
file_names=$(ls *.vnnlib)

#return to root directory
cd $root_folder

#loop over all the files
for f in $file_names
do
    ./abduction_algorithm/adversarial_robustness_algorithm.sh $benchmark_name $epsilon $number_of_input_variables $root_folder $f $results_folder
    echo $f
    #remove output file generated by the verifier
    rm $root_folder/out.txt
done
