import os
from pathlib import Path

User_Dir = str(Path.home()) + '/'
User_Sub_Dir = 'Gitika/Github_Repositories/'
Working_Dir = User_Dir + User_Sub_Dir

Home = Working_Dir + 'Mega_PartI/'

# HPC scratch location
scratch = Path("/data/scratch") / os.environ["USER"]

if scratch.exists():
    Base_Dir = str(scratch / "Gitika/Github_Repositories/Mega_PartI/Pipeline_Runs") + "/" 
    #Base_Dir = str(scratch / "Pipeline_Runs") + "/"
else:
    Base_Dir = Home + "Pipeline_Runs/"

print('User_Dir',User_Dir)
print('Base_Dir',Base_Dir)

Kepler_Dir = Home+'Kepler/'
Kepler_LCS_Dir = Home+'Kepler_Binned_LCS/'
Config_Dir = Home+'Config/'
KOI_Table_Filename = 'koi_cumulative_2025.06.28_01.24.15.csv'
Kepler_Error_Filename = 'kepler_folded_lcs_snr50_all_binned_err.npy'
#Infer_LC_Dir = Home+"Raw_LC/"
Infer_LC_Dir = Base_Dir+"Kepler_RsRp_Bins/"





# from pathlib import Path

# # Pegasus Paths
# #User = '/mnt/home/project/cshukla.gitika/'
# User_Dir = str(Path.home()) + '/'
# User_Sub_Dir = 'Gitika/' + 'Github_Repositories/'
# Working_Dir = User_Dir + User_Sub_Dir

# #Working_Dir = Path(Working_Dir)
# #Working_Dir.mkdir(parents=True, exist_ok=True)

# Home = Working_Dir + 'Mega_PartII/'
# #Base_Dir = Home+'Test_Runs_Pegasus/'
# Base_Dir = Home+'Pipeline_Runs/'
# Kepler_Dir = Home+'Kepler/'
# Kepler_LCS_Dir = Home+'Kepler_Binned_LCS/'
# Config_Dir = Home+'Config/'
# KOI_Table_Filename = 'koi_cumulative_2025.06.28_01.24.15.csv'
# Kepler_Error_Filename = 'kepler_folded_lcs_snr50_all_binned_err.npy'
# #Infer_LC_Dir = Home+"Raw_LC/"
# Infer_LC_Dir = Base_Dir+"Kepler_RsRp_Bins/"

