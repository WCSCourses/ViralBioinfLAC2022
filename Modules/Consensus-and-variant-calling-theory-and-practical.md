# Consensus and variant calling
## Overview

![Consensus-image1.png](https://github.com/WCSCourses/ViralBioinfAsia2022/blob/main/Modules/images/Consensus-image1.png)

## Creating a consensus with BCFtools

Let's start by preparing the folder and files we will be working with:  

``cd /home/manager/course_data/Consensus_and_variant_calling/dengue-corrected``

``cp /home/manager/course_data/Reference_alignment/07-dengue_align/annotation.txt .``

``cp /home/manager/course_data/Reference_alignment/07-dengue_align/dengue-genome.fa .``

``samtools view -s 0.01 -b /home/manager/course_data/Reference_alignment/07-dengue_align/dengue-aln.bam > dengue-subsample.bam``

``samtools sort dengue-subsample.bam -o dengue-subsample.sorted.bam``

``samtools index dengue-subsample.sorted.bam``

``rm dengue-subsample.bam`` 

>**Note**: To make this run much faster on your laptops, we are going to be subsampling the .bam file you created in the 'Reference_alignment' module. When generating a consensus sequence on real data, we would strongly recommend using the full .bam file as the result may be more accurate. 

Ok, all the prep work is done!  

Now that we have our alignment file, we can generate a consensus sequence. We will explore two separate ways to generate this consensus:

1. We will use ``bcftools mpileup`` and ``bcftools call`` to generate a "majority rules" consensus and the output format will be in **.fasta** file format. For many downstream applications this will be the output you will likely want. 
2. We will also be using use ``bcftools mpileup`` and ``bcftools call`` but will also add in the **vcfutils.pl vcf2fq** script to generate a **.fastq** file that allows for ambiguities at each position if there is a mixture of variants present in the sample.

### Example 1 - Using **bcftools** to generate a **.fasta** "majority rules" consensus file

>You can check the arguments we will be using for the different commands of bcftools by typing in the command line "``bcftools mpileup``" or "``bcftools call``", for example.

Let´s index our reference:

``samtools faidx dengue-genome.fa``

``bcftools mpileup -f dengue-genome.fa dengue-subsample_01p.bam | bcftools call -mv -Oz --ploidy-file annotation.txt -o calls.vcf.gz``

``tabix calls.vcf.gz``

``cat dengue-genome.fa | bcftools consensus calls.vcf.gz > dengue-cns.fa``

Finally, we will use a quick hack to rename the header of the .fa file we just generated:

``sed 's/>MN566112.1 Dengue virus 2 isolate New Caledonia-2018-AVS127, complete genome/>dengue-consensus-bcftools/' dengue-cns.fa > dengue-consensus-bcftools.fa``

``rm calls*``

``rm dengue-cns.fa``

We created (and removed) several files here. The one that contains the consensus genome you are looking for is **dengue-consensus-bcftools.fa**

### Example 2 - Using **samtools/bcftools** along with vcfutils.pl vcf2fq to generate a **.fastq** consensus file that allows for ambiguities

Here\'s how we will call this command:

``bcftools mpileup -f dengue-genome.fa dengue-subsample.sorted.bam | bcftools call -c --ploidy-file annotation.txt | vcfutils.pl vcf2fq > dengue-consensus-full.fq``

Finally, we will again use a quick hack to rename the header of your output file:

``sed 's/@MN566112.1/>dengue-consensus-vcf2fq/' dengue-consensus-full.fq > dengue-consensus-vcf2fq.fq`` 

``rm dengue-consensus-full.fq``

We have created (and removed) several files here. The one that contains the consensus genome you are looking for is **dengue-consensus-vcf2fq.fq**

## Visualizing the difference between these files

So what effectively is the difference between the **dengue-consensus-bcftools.fa** and **dengue-consensus-vcf2fq.fq** files we´ve generated? If we were to align these back to the reference genome dengue-genome.fa we can see the ambiquity present in the **dengue-consensus-vcf2fq.fq** whereas the **dengue-consensus-bcftools.fa** merely shows a complete consensus change at this position.

![Consensus-image2.png](https://github.com/WCSCourses/ViralBioinfAsia2022/blob/main/Modules/images/Consensus-image2.png)

## Variant calling

There are a number of different variant callers available including FreeBayes, LoFreq, VarDict, and VarScan2. In this tutorial, we will be using LoFreq* (i.e. LoFreq version 2) - a fast and sensitive variant-caller for inferring SNVs and indels from next-generation sequencing data. LoFreq\* makes full use of base-call qualities and other sources of errors inherent in sequencing (e.g. mapping or base/indel alignment uncertainty), which are usually ignored by other methods or only used for filtering.

LoFreq\* can run on almost any type of aligned sequencing data (e.g. Illumina, IonTorrent or Pacbio) since no machine- or sequencing-technology dependent thresholds are used. It automatically adapts to changes in coverage and sequencing quality and can therefore be applied to a variety of data-sets e.g. viral/quasispecies, bacterial, metagenomics or somatic data.

LoFreq\* is very sensitive; most notably, it is able to predict variants below the average base-call quality (i.e. sequencing error rate). Each variant call is assigned a p-value which allows for rigorous false positive control. Even though it uses no approximations or heuristics, it is very efficient due to several runtime optimizations and also provides a (pseudo-)parallel implementation. LoFreq\* is generic and fast enough to be applied to high-coverage data and large genomes. On a single processor it takes a minute to analyze Dengue genome sequencing data with nearly 4000X coverage, roughly one hour to call SNVs on a 600X coverage *E.coli* genome and also roughly an hour to run on a 100X coverage human exome dataset.

For more details on the original version of LoFreq see [Wilm et al. (2012)](https://pubmed.ncbi.nlm.nih.gov/23066108/).

LoFreq comes with a variety of subcommands. By just typing ``lofreq`` you will get a list of available commands. The command we will be using today is lofreq call which will call variants in our dengue alignment from the previous section. The output for our variant calls will be in variant call format (VCF).

### Running LoFreq

Now let's see what ``lofreq call`` can do. For this tutorial, we will be using the standard presets for lofreq but when running this on your own datasets, I would encourage you to explore all the options available in lofreq by checking out the [github page](https://github.com/CSB5/lofreq).


``lofreq call -b dengue-subsample.sorted.bam -f dengue-genome.fa > dengue-variants-original-ref.vcf`` **NOT WORKING**

``lofreq call -f dengue-genome.fa -o dengue.vcf dengue-subsample.sorted.bam``

      The outputted VCF file consists of the following fields:
      - CHROM: the chromosome – in this case the SARS2 ref sequence NC_045512.2
      -POS: the position on the chromosome the variant is at
      - ID: a ‘.’ but LoFreq can be run with a database of known variants to annotate this field
      - REF: the reference base at this position
      - ALT: the alternate base (the mutated base) at this position
      - QUAL: LoFreq’s quality score for the variant
      - FILTER: whether it passed LoFreq’s filters e.g. PASS
      - INFO: Detailed Information
        - DP=1248; depth = 1248
        - AF=0.995192; Alt Frequency (Mutation Frequency) = 99.5%
        - SB=0; Strand Bias test p-value
        - DP4=0,1,604,638: Coverage of the ref base in Fwd and Rev, and the alt base in Fwd and Rev

This will take a few minutes to run depending on your system, but you should soon see a new file in your directory called: **dengue.vcf**

**Question1 – the consensus level mutations should be readily apparent (with frequencies near 100%) – is there any sub-consensus variants called by LoFreq?**

>Hint: You can open this file with the ``more`` command to answer this question. What do you think about the reference used?

Let´s re-map the reads to the new consensus genome we derived above (dengue-consensus-bcftools.fa) and then re-run lofreq:

``bwa index dengue-consensus-bcftools.fa``

``bwa mem dengue-consensus-bcftools.fa /home/manager/course_data/Reference_alignment/07-dengue_align/dengue_R1.fq.gz /home/manager/course_data/Reference_alignment/07-dengue_align/dengue_R2.fq.gz > dengue-consensus-aln.sam``

``samtools view -bS dengue-consensus-aln.sam > dengue-consensus-aln.bam``

``samtools sort dengue-consensus-aln.bam -o dengue-consensus.sorted.bam``

``samtools index dengue-consensus.sorted.bam``

``rm dengue-consensus-aln*``

**Question2 – how many reads mapped to the reference sequence?**


As we mentioned previously, we would proceed with the **lofreq** run from this point, but in order to speed things up for the course, we are going to subsample our .bam file before we run lowfreq again:


``samtools view -s 0.01 -b dengue-consensus.sorted.bam > dengue-cons-subsample.bam``

``samtools sort dengue-cons-subsample.bam -o dengue-cons-subsample.sorted.bam``

``samtools index dengue-cons-subsample.sorted.bam``

``rm dengue-cons-subsample.sorted.bam``

``samtools view -c -F4 dengue-cons-subsample.sorted.bam``

>As you can see from this final command, we now have 49829 reads mapped - not ideal in a normal situation, but good enough for illustrative purposes. 

Let's continue by building an index for our new consensus reference genome:

``samtools faidx dengue-consensus-bcftools.fa``

``lofreq call -f dengue-consensus-bcftools.fa -o dengue-cons.vcf dengue-cons-subsample.sorted.bam``

This will take a few minutes to run depending on your system, but you should soon see a new file in your directory called: **dengue-cons.vcf**

**Question3: how many variants has lofreq detected?**

**Question4: what type of variants are they?**

**Question5: discuss these results considering the reference sequences used in both cases**


## Practice

Now let's take what you've learnt and try it out on another dataset! In this example, we will be looking for variants from a Chikungunya virus alignment.

To start, we´ll help you with the first commands for this practical activity:

``mkdir /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected``

``ln -s /home/manager/course_data/Reference_alignment/07-chikv-align/annotation.txt /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected/``

``ln -s /home/manager/course_data/Reference_alignment/07-chikv-align/chikv-genome.fasta /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected/``

``samtools view -s 0.01 -b /home/manager/course_data/Reference_alignment/07-chikv-align/chikv-aln.sorted.bam > /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected/chikv-subsample.bam``

``samtools sort /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected/chikv-subsample.bam -o /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected/chikv-subsample.sorted.bam``

``samtools index /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected/chikv-subsample.sorted.bam``

``rm /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected/chikv-subsample.bam``

``cd /home/manager/course_data/Consensus_and_variant_calling/chikv-corrected/``

From here you should be able to follow the steps above to answer the questions below:

**Question6: How many mapped reads do you have in the 1% subsampled 'chikv-consensus-subsample_01p.bam' file?**
>Answer: 48194
>
**Question7: What is the allele frequency at position 757?**
>Answer: A-->G    AF=0.062893
