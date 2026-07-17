#!/bin/bash

ratio1=2
ratio2=20
seed=3
snr_min=2e8
snr_max=2e8
noise="gaussian"
train_network="curriculam_noise"
ldc_dist='uniform'
nproc=24 # updated for local machine




queue="debug"
walltime="00:20:00"

# queue="regular"
# walltime="00:20:00"

# queue="project"
# walltime="96:00:00"

# config_file="train_config_debug.json"
# log_dir="master_log_quick"

config_file="train_config.json"
log_dir="master_log"

# Home directory
User_Dir="$HOME/"
User_Sub_Dir="Gitika/Github_Repositories/"
Working_Dir="${User_Dir}${User_Sub_Dir}"
Home="${Working_Dir}Mega_PartI/"

# HPC scratch location
SCRATCH="/data/scratch/$USER"

if [ -d "$SCRATCH" ]; then
    data_Dir="${SCRATCH}/Gitika/Github_Repositories/Mega_PartI/Pipeline_Runs"
else
    data_Dir="${Home}Gitika/Github_Repositories/Mega_PartI/Pipeline_Runs"
fi

log_dir="master_log"

rsrp_dir="RsRp_${ratio1}_${ratio2}"
base_dir="${data_Dir}/${log_dir}/${rsrp_dir}"
mkdir -p "${base_dir}"

echo "User_Dir    = $User_Dir"
echo "Working_Dir = $Working_Dir"
echo "Home        = $Home"
echo "data_Dir    = $data_Dir"

export ratio1 ratio2 seed base_dir config_file snr_min snr_max noise train_network nproc ldc_dist

PBS_JOBNAME0="gen_config_${ratio1}_${ratio2}"
PBS_JOBNAME1="genlc_${ratio1}_${ratio2}_s1"
PBS_JOBNAME2="genlc_${ratio1}_${ratio2}_s2"
PBS_JOBNAME3="genlc_${ratio1}_${ratio2}_s3"
PBS_JOBNAME4="genlc_${ratio1}_${ratio2}_s4"
PBS_JOBNAME5="train_${ratio1}_${ratio2}"
# =========================
# Detect PBS availability
# =========================

if command -v qsub >/dev/null 2>&1; then
    echo "Running on HPC (PBS mode)"

    jid0=$(qsub -S /bin/bash \
        -v ratio1,ratio2,seed,base_dir,config_file,snr_min,snr_max,noise,train_network,ldc_dist \
        -q "debug" \
        -N $PBS_JOBNAME0 \
        gene_config.sh)
    echo "jid0 = $jid0"

    # jid1=$(qsub -S /bin/bash \
    #     -q $queue \
    #     -l walltime=$walltime \
    #     -W depend=afterok:${jid0} \
    #     -v ratio1,ratio2,seed,base_dir \
    #     -N $PBS_JOBNAME1 \
    #     gene_data_set1.sh)

    # jid2=$(qsub -S /bin/bash \
    #         -q $queue \
    #         -l walltime=$walltime \
    #         -W depend=afterok:${jid0} \
    #         -v ratio1,ratio2,seed,base_dir \
    #         -N $PBS_JOBNAME2 \
    #         gene_data_set2.sh)
    
    # jid3=$(qsub -S /bin/bash \
    #         -q $queue \
    #         -l walltime=$walltime \
    #         -W depend=afterok:${jid0} \
    #         -v ratio1,ratio2,seed,base_dir \
    #         -N $PBS_JOBNAME3 \
    #         gene_data_set3.sh)
            
    # jid4=$(qsub -S /bin/bash \
    #         -q $queue \
    #         -l walltime=$walltime \
    #         -W depend=afterok:${jid0} \
    #         -v ratio1,ratio2,seed,base_dir \
    #         -N $PBS_JOBNAME4 \
    #         gene_data_set4.sh)    
            
    # jid5=$(qsub -S /bin/bash \
    #         -q $queue \
    #         -l walltime=$walltime \
    #         -W depend=afterok:${jid1}:${jid2}:${jid3} \
    #         -v ratio1,ratio2,seed,base_dir \
    #         -N $PBS_JOBNAME5 \
    #         train_cpu.sh)
            
    walltime="96:00:00"
    jid5=$(qsub -S /bin/bash \
            -q $queue \
            -l walltime=$walltime \
            -v ratio1,ratio2,seed,base_dir \
            -N $PBS_JOBNAME5 \
            train_cpu.sh)
            
else
    echo "Running locally (no PBS detected)"

    # run directly
    bash gene_config.sh
    # bash gene_data_set1.sh
    # bash gene_data_set2.sh
    # bash gene_data_set3.sh
    # bash gene_data_set4.sh
    bash train_cpu.sh
fi