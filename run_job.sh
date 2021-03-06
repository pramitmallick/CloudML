#!/bin/bash

#SBATCH --verbose
#SBATCH --job-name=2synch
#SBATCH --mem=100GB
#SBATCH --output=out.synch.2.dist.%j
#SBATCH --error=err.synch.2.dist.%j
#SBATCH --time=100:00:00

##SBATCH --partition=knl
##SBATCH -w, --nodelist=c99-[07-08]
#SBATCH --nodes=2
#SBATCH --cpus-per-task=1
#SBATCH --ntasks-per-node=2
##SBATCH --gres=gpu:3

echo "Job started"

. /scratch/pm2758/anaconda3/etc/profile.d/conda.sh

conda activate pytorch_v1

module purge
module load gcc/6.3.0
module load openmpi/intel/3.1.3
module load cuda/9.0.176
module load nccl/cuda9.0/2.4.2
module load ninja/intel/1.8.2

# mpiexec -n 3 python dist_sst.py
# mpirun -n 4 python mpi_dist_trial.py
# mpirun -n 2 python mpitrial.py

python mp_dist_synch.py 2
# python mp_dist_asynch.py 5

echo "Job completed"
