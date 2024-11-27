# _Code for_: Temperature-driven biogeography of marine giant viruses infecting picoeukaryotes _Micromonas_
_By David Demory and Hisashi Endo, 2024._ 

## General description
 This repository contains scripts to reproduce figures and analyses for our study on Temperature-driven biogeography of marine giant viruses infecting picoeukaryotes _Micromonas_ published on * XXX *.
 The codes are written in R, using jupyter notebook and Matlab 2023_a. You will need the following installed on your computer:
 - **R version 4.2.3 (2023-03-15)** with the following packages: ggplot2, ggExtra, dplyr, reshape2, dplyr, ape, vegan, viridis, maps, grid, gridBase, latex2exp, ggmap, RColorBrewer, mgcv, pROC.
 - **Jupyter Notebook** with R kernel (https://jupyter.org).
 - **MATLAB version 2023_a** with m_map (https://www-old.eoas.ubc.ca/~rich/map.html).
 
## Folder content description

### ./src
Contains the source code to run the analyses and figures.
- **figure1_env_descriptors_mpv_com_13092024.ipynb** (Jupyter notebook and R): produces the entire figure 1.
- **figure2_mpv_groups_temperature_distribution_17102024.ipynb** (Jupyter notebook and R): produces figure 2b, 2c and 2d. ==Figure 2a is made manually using GUI-based processes (PRECISE PROCESSES)==.
- **figure3_mpv_host_network.ipynb**  (Jupyter notebook and R): produces the entire figure 3.
- **figure4and5_ROC_analysis_17102024.ipynb** (Jupyter notebook and R): produces figure 4 and figure 5 (left and right pannels only).
- **figure5_mpv_distribution_map_17102024.m** (Matlab): produces figure 5 central panels (maps).
- **sifigures_model_arctic_data.ipynb** (Jupyter notebook and R): produces SI figures 1,2 and 3. SI figure S4 and S5 are made manually using GUI-based processes.

### ./data
Contains data used to plot the figures and do the analyses.
- **df_MicV_X_merge_stdz.txt**: TARA frequency matrix for MicV X group. We have txt files for major groups A, B, C and Pol and minor groups A1, A2, B1, B2, Pol1 and Pol2.
- **env_ncldv_eupho_df_mpv.txt**: TARA Environmental data for each stations.
- **GFCM21_SRA2_1_N_ts.1-1200.nc**: Present worldwide ocean temperatures (2010 - 2020) from IPCC SRES_AR4. 
- **Info_Virus_New2023.txt**: Alignement information for virus groups.
- **./data_Maat_2017** contains data from Maat _et al._ Viruses 2017 (https://www.mdpi.com/1999-4915/9/6/134) in xlsx form for host (**Polaris_Host.xlsx**) and virus (**Polaris_Virus.xlsx**). Sheets are experimental temperatures: 0.5, 2.5, 3.5 and 7C. First column = cumulative time (in days) and second column = abundances (in particles/ml).

### ./figures
Output folder with figures produced by the scripts in ./src
