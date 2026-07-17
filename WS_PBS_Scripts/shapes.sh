#!/bin/bash

ratio1=2
ratio2=3
seed=3

queue="debug"
walltime="04:00:00"

# queue="project"
# walltime="03:00:00"

# config_file="train_config_debug.json"
# log_dir="master_log_quick"

config_file="train_config.json"
log_dir="master_log"

# Home directory
User_Dir="$HOME/"
User_Sub_Dir="Gitika/Github_Repositories/"
Working_Dir="${User_Dir}${User_Sub_Dir}"
Home="${Working_Dir}Mega_PartII/"

# HPC scratch location
SCRATCH="/data/scratch/$USER"

if [ -d "$SCRATCH" ]; then
    data_Dir="${SCRATCH}/Gitika/Github_Repositories/Mega_PartII/Pipeline_Runs"
else
    data_Dir="${Home}Gitika/Github_Repositories/Mega_PartII/Pipeline_Runs"
fi

shape_dir="shapes"
base_dir="${log_dir}/${shape_dir}"
base_dir="${data_Dir}/${log_dir}/${shape_dir}"
mkdir -p "${base_dir}"

echo "User_Dir    = $User_Dir"
echo "Working_Dir = $Working_Dir"
echo "Home        = $Home"
echo "data_Dir    = $data_Dir"

# shape_dir="shapes"
# base_dir="${log_dir}/${shape_dir}"
# mkdir -p "${base_dir}"

export ratio1 ratio2 seed base_dir config_file

PBS_JOBNAME0="shape_gen"

# =========================
# Detect PBS availability
# =========================

if command -v qsub >/dev/null 2>&1; then
    echo "Running on HPC (PBS mode)"

    jid0=$(qsub -S /bin/bash \
        -q $queue \
        -l walltime=$walltime \
        -v ratio1,ratio2,seed,base_dir,config_file \
        -N $PBS_JOBNAME0 \
        gene_shapes.sh)

else
    echo "Running locally (no PBS detected)"

    # run directly
    bash gene_shapes.sh
    
fi
