**Viral Genomics and Bioinformatics Latin America and the Caribbean**
10 - 14 October 2022

**Topic: Phylogenetics & Virus Typing**

**Instructors: Dr. Carolina Torres & Dr. Marta Giovanetti**


**Introduction to the Hands-on exercises**


**DATASET 1: SARS-CoV-2**

SARS-CoV-2 diversity and evolution are reflected by both variants and lineages. The Pango nomenclature is a system for identifying SARS-CoV-2 genetic lineages of epidemiological relevance and is being used by researchers and public health agencies worldwide to track the transmission and spread of SARS-CoV-2, including variants of concern (VOCs) (https://www.pango.network/).

The **objective** of the practical activity is to assign the Pango lineage to a group of SARS-CoV-2 sequences obtained in Latin America.

For that purpose, we have built a dataset of complete genome sequences consisting of 40 reference sequences of several Pango lineages (indicated at the beginning of the sequence names) and 10 sequences from some Latin American countries (indicated as “query” at the beginning of the sequence names).


**DATASET 2: Dengue virus (DENV)**

Dengue infections are caused by four closely related viruses (DENV-1 to DENV-4). DENV-4 is classified into four genotypes (I-III and Sylvatic).
The **objective** of the practical activity is to genotype three DENV-4 isolates that circulated in Brazil in 2012-2013 (“query”) and determine if they belong to a single transmission chain. 

For that purpose, we have built a dataset consisting of 37 complete genome sequences of this virus including reference sequences of the DENV-4 genotypes (indicated at the end of the sequence names as I-III and Sylvatic), the sequences of interest (indicated as “query” at the beginning of the sequence names) and sequences of DENV-1 to DENV-3 as outgroup.



**Activity I: Multiple Sequence Alignment (MSA)**

**Specific objectives of this practice:**

- To become familiar with the MAFFT and Aliview programs.
- To obtain a sequence alignment for later use in phylogeny.

To carry out an alignment, the sequences need to be available in a file that can be read by the programs. In general, the FASTA format is accepted by most sequence alignment and edition programs. The time required for the analysis will depend on the power of the computer and the number of sequences to be analyzed. In general, it can be estimated that the computation time will increase linearly with the length of the sequences, and exponentially with the number of sequences to be aligned.

The datasets (unaligned set of sequences: **LAC_SARSCoV2.fasta / LAC_DENV.fasta**) are located in:

/home/manager/course_data/Phylogenetics_methods_and_tree_building/LAC/1_SARSCoV2/LAC_SARSCoV2.fasta

/home/manager/course_data/Phylogenetics_methods_and_tree_building/LAC/2_DENV.fasta


**Exercise**

**A.	Alignment with MAFFT**

MAFFT is an advanced tool that can align using different alignment algorithms for different applications such as L-INS-i (accurate; recommended for <200 sequences), FFT-NS-2 (fast; recommended for >2,000 sequences), etc. It can be run locally or on online servers. To understand the algorithms and their use cases, please refer to https://mafft.cbrc.jp/alignment/software/algorithms/algorithms.html

To use it on the VM, type mafft on the command-line, mafft --help will give you information about the proper syntax. 

Please note that the procedure below is for the SARS-CoV-2 dataset, so if you will be analyzing the Dengue dataset as well, you need to go to the directory where that dataset is located and replace the file names in the instructions below.


1. Open a Terminal and go into the directory	that contains the dataset to align: LAC_SARSCoV2.fasta

/home/manager/course_data/Phylogenetics_methods_and_tree_building/LAC/1_SARSCoV2/LAC_SARSCoV2.fasta

2. Type: mafft --auto LAC_SARSCoV2.fasta > LAC_SARSCoV2_aln.fasta

Usage:
mafft [options] input > output

--auto  automatically switches algorithm according to data size.


**[OPTIONAL] Alignment with Muscle (in Aliview).**

1. Execute Aliview and open the alignment: File  Open File: LAC_SARSCoV2.fasta
3. Explore the Aliview window and locate the following elements: Sequence names, Sequences, Ruler.
4. Perform an alignment with the default program (Muscle): Align  Realign everything  OK.
[The program will start, and different steps will be shown. Once the alignment is completed, the output file will be automatically shown.]
4. Check the alignment and realign regions if needed: 
Select the region to realign -> Align -> Realign selected block.
5. Save this alignment: File -> Save as fasta -> LAC_SARSCoV2_muscle_aln.fasta

**B.	Editing the sequence alignment**
After aligning, it is advisable to visually review the sequence alignments obtained before proceeding to phylogenetic analysis. Sometimes, a manual edition is needed, especially at the ends of the alignment, where only some sequences have reliable information. For this exercise, you can use any of the alignments generated from MAFFT or Aliview (Muscle). 

The following instructions show the use of the alignment of SARS-CoV-2 generated with MAFFT.

**Edition in Aliview:**

1. Execute Aliview and open the alignment: File -> Open File: LAC_SARSCoV2_aln.fasta
2. Check the alignment and realign regions if needed: 
Select the region to realign -> Align -> Realign selected block.
3. Select the region to be deleted:
a) For the left end of the alignment, select the last nucleotide of the region to be deleted (as in the figure below):
 
- Select -> Expand Selection Left 
- Edit -> Delete selected

![image](https://user-images.githubusercontent.com/64616141/191759035-0462d641-70ce-4e6f-9a56-398ed8951931.png)


b) Repeat the procedure for the right end, select the first nucleotide of the region to be deleted (as in the figure below):
- Select -> Expand Selection Right
- Edit -> Delete selected
 
 ![image](https://user-images.githubusercontent.com/64616141/191759156-904fe580-5697-4394-b6da-35cc6efb3008.png)


c) Repeat the procedure for internal regions if needed:
- Select the region -> Edit -> Delete selected.

4. Save the edited alignment:
-	File -> Save as fasta -> LAC_SARSCoV2_aln_edit.fasta

This file will be used to estimate the substitution model and infer the phylogenetic tree.

