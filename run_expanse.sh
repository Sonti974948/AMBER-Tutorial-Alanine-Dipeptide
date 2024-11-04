#!/bin/bash
#SBATCH --job-name="chignolin_run"
#SBATCH --output="job.out"
#SBATCH --partition=gpu-debug
#SBATCH --nodes=1
#SBATCH --gpus=1
#SBATCH --ntasks-per-node=1
#SBATCH --mem=50G
#SBATCH --account=ucd187
#SBATCH --no-requeue
#SBATCH --mail-user=ssiddharth@ucdavis.edu
#SBATCH --mail-type=ALL
#SBATCH -t 00:30:00


module purge
module load shared
module load gpu/0.15.4
module load slurm
module load openmpi/4.0.4
module load cuda/11.0.2
module load amber/20

export PATH=$PATH:$HOME/bin
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
source $AMBERHOME/amber.sh
#pmemd.cuda -O -i min.in -o min.out -p ALA.prmtop -c ALA.rst -r min.rst -x min.nc -AllowSmallBox
#tleap -f tleap.in
#pmemd.cuda -O -i heat.in -o heat.out -p ALA.prmtop -c min.rst -r heat.rst -x heat.nc -ref min.rst -AllowSmallBox
pmemd.cuda -O -i prod.in -o prod.out -p ALA.prmtop -c heat.rst -r prod.rst -x prod.nc -ref heat.rst -AllowSmallBox
#pmemd.cuda -O -i eq2.in -o eq2.out -p ALA.prmtop -c eq1.rst -r eq2.rst -x eq2.nc -ref eq1.rst
#pmemd.cuda -O -i md_gamd.in -o md_gamd.out -p ALA.prmtop -c ALA.rst -r md_gamd.rst -x md_gamd.nc
