# Reference alignment

## Overview

![Reference-alignment-image1](https://github.com/WCSCourses/ViralBioinfAsia2022/blob/main/Modules/images/Reference-alignment-image1.png)

## Practical data sets

Let's start by doing some quick prep/housekeeping on our dataset:


``unzip /home/manager/course_data/Reference_alignment/Reference_alignment.zip``

``mv /home/manager/course_data/Reference_alignment/Reference_alignment/07-dengue_align /home/manager/course_data/Reference_alignment/``

``mv /home/manager/course_data/Reference_alignment/Reference_alignment/07-chikv-align /home/manager/course_data/Reference_alignment/``

``rm -r /home/manager/course_data/Reference_alignment/Reference_alignment/``

``rm -r /home/manager/course_data/Reference_alignment/__MACOSX/``



>*NOTE:* Be careful when using 'rm -r' ! You can easily delete quite a bit of data this way with no chance to recover it! When doing this, it's  a good idea to use *absolute paths* to avoid deleting something important by accident.

Now that is done, let's navigate to the proper folder:


``cd /home/manager/course_data/Reference_alignment/07-dengue_align/``


## Preparing our raw reads for mapping

Let's first start by cleaning up our data:


``trim_galore -q 25 --length 50 --paired dengue.read1.fq.gz dengue.read2.fq.gz``


>**--q 25** = trim the 3' end of the reads -- remove nucleotides less
than Phred Quality 25

>**\--length 50** = after adapter and quality trimming, remove reads less
than 50bp in length

>**\--paired** = the names of the paired fastq files to analyze in order
(Read 1 then Read 2)

## Aligning your reads to a reference genome with BWA

There are many tools available to align reads onto a reference sequence: BWA, Novoalign, bowtie2, STAR to name but a few. In this practical, we will be using **BWA** (http://bio-bwa.sourceforge.net).

>BWA (Burrows--Wheeler aligner) is a commonly used software designed to
>map sequence reads to a reference genome. BWA actually has three
>variations: BWA-backtrack (Li and Durbin, 2009), BWA-SW (Li and Durbin,
>2010) and BWA-MEM (Li, 2013). In this exercise, we will be using
>BWA-MEM, which is typically preferred for longer reads due to its speed
>and accuracy.

To get started, let's start by indexing the reference genome:

``bwa index dengue-genome.fa``
  
You should now have some additional files in your directory:

-rw-r----- 1 manager manager 10B Aug 1 17:03 dengue-genome.fa.amb

-rw-r----- 1 manager manager 100B Aug 1 17:03 dengue-genome.fa.ann

-rw-r----- 1 manager manager 11K Aug 1 17:03 dengue-genome.fa.bwt

-rw-r----- 1 manager manager 2.6K Aug 1 17:03 dengue-genome.fa.pac

-rw-r----- 1 manager manager 5.3K Aug 1 17:03 dengue-genome.fa.sa

Now let's align the samples to our reference genome using ``bwa mem``:

``bwa mem dengue-genome.fa dengue.read1.fq.gz dengue.read2.fq.gz > dengue-aln.sam``

## Manipulating your SAM file with SAMtools

>SAMtools is a library and software package for parsing and manipulating
>alignments in the SAM/BAM format. It is a multifunctional set of tools
>that is able to convert from other alignment formats, sort and merge
>alignments, remove PCR duplicates, generate per-position information in
>the pileup format.

If you check your directory again, you should now see a file called **dengue-aln.sam**

This is an example of a **SAM** file, which is the common output file type
for deep sequencing reads. SAM files tend to take up a lot of space on
your computer however so let's go ahead and convert this file to a **BAM**
file, which is the compressed version. We will be using ``samtools view`` to do
this:

``samtools view -bS dengue-aln.sam > dengue-aln.bam``
  
> In this command, we are telling **SAMtools** to **view** the file
> **dengue-aln.sam** and direct (**\>**) the output into a file called
> **dengue-aln.bam**. The **-bS** tells samtools that we want the
> output in BAM format (**b**) and to auto-detect the format the input
> data is in (**S**).

**Question: How big is the SAM file compared to the BAM file?**

> If your SAM file is 0B (i.e. 0 bytes = empty) then something went wrong with the BWA
> alignment step, so restart from there. If your SAM file is fine (i.e. >0), but your BAM file is 0B
> (i.e. empty), then something went wrong with your SAM to BAM conversion so re-do that section.

To prepare our new .bam file for downstream use, we should now sort and index it using again **SAMtools**:

``samtools sort dengue-aln.bam -o dengue-aln.sorted.bam``

``samtools index dengue-aln.sorted.bam``

``rm dengue-aln.sam``

``rm dengue-aln.bam``

> In this set of commands, we are using **SAMtools** to sort the BAM
> file **dengue-aln.bam** and output (**-o**) a new file called
> **dengue-aln.sorted.bam**. We are then using **SAMtools** to index the BAM file
> **dengue-aln.sorted.bam** - indexing enables faster searches downstream and
> requires the data to be sorted. Finally, since we no longer need our
> original uncompressed SAM file and unsorted BAM file and we don\'t
> want to tie up our server with unneeded files, we then use the **rm**
> command to remove the original **dengue-aln.sam** file and the old
> unsorted **dengue-aln.bam** file. *Do be careful when using the **rm**
> command though, once you delete a file this way it is gone forever!*

There should now be two additional files in your directory: 
- **dengue-aln.sorted.bam** (the BAM file) 
- **dengue-aln.sorted.bam.bai** (the BAM index file). 

To check this you can use:

``ls -lh``

> The **-l** modifier of this command will list your files in the long
> list format while the **-h** modifier will output the file sizes in a
> human readable format.

The output of this command should look something like this:

-rw-r\-\-\-\-- 1 manager manager 18B Aug 1 18:28 annotation.txt

-rw-r\-\-\-\-- 1 manager manager 11K Aug 1 16:55 dengue-genome.fa

-rw-r\-\-\-\-- 1 manager manager 10B Aug 1 17:03 dengue-genome.fa.amb

-rw-r\-\-\-\-- 1 manager manager 100B Aug 1 17:03 dengue-genome.fa.ann

-rw-r\-\-\-\-- 1 manager manager 11K Aug 1 17:03 dengue-genome.fa.bwt

-rw-r\-\-\-\-- 1 manager manager 2.6K Aug 1 17:03 dengue-genome.fa.pac

-rw-r\-\-\-\-- 1 manager manager 5.3K Aug 1 17:03 dengue-genome.fa.sa

-rw-r\-\-\-\-- 1 manager manager 424M Aug 1 17:22 dengue-aln.sorted.bam

-rw-r\-\-\-\-- 1 manager manager 96B Aug 1 17:23 dengue-aln.sorted.bam.bai

-rw-r\-\-\-\-- 1 manager manager 289M Aug 1 16:55 dengue.read1.fq.gz

-rw-r\-\-\-\-- 1 manager manager 311M Aug 1 16:56 dengue.read2.fq.gz

One common thing to check is how many reads have aligned to the reference, and how many did not. 

> Reminder: the 2nd column in the SAM file contains the flag for the read alignment. If the flag
> includes the number 4 flag in its makeup then the read is unmapped, if it doesn’t include the
> number 4 then it is mapped

Samtools can report this for us easily:

**Number of mapped reads:**

``samtools view -c -F4 dengue-aln.sorted.bam``

An explanation of this command is as follows:

>-   ``samtools view`` to view the file dengue-aln.sorted.bam

>-   -c = count the read alignments

>-   -F4 = skip read alignments that have the unmapped Flag 4

**Number of unmapped reads:**

``samtools view -c -f4 dengue-aln.sorted.bam``

>This time we use -f4 = only include read alignments that do have the
>unmapped flag 4

**Question: how many reads are mapped to the dengue-genome.fa genome?**

**Question: how many reads are unmapped?**

>If your results show that you have **5,178,553 mapped** reads and
>**1,740,506 unmapped** reads, you are doing great!

Another way you can get these data is to use:

``samtools idxstats dengue-aln.sorted.bam``

This should give you the mapped and unmapped data with a single command. ``samtools idxstats`` splits unmapped reads into two categories:

1. Those that are unmapped BUT whose pair does map to the given reference column - these are reported in the UnmappedReads column (4th column) of the corresponding reference sequence line.
2. Those that are unmapped AND whose pair is also unmapped - these are reported in the UnmappedReads column (4th column) of the no reference sequence line (*).

**RefName** **RefLen**	**MappedReads**	**UnmappedReads**

MN566112.1	  10722	      5178553	        132806

/*	            0	          0	              1607700

Finally, we can also dig deeper into the data to look at insert size length, number of mutations and overall coverage by creating a stats file:

``samtools stats dengue-aln.sorted.bam > dengue_stats.txt``

>The first section of this file is a summary of the aligned data set
>which can give you an idea of the quality of your data set and overall
>alignment. If you open the file you just made, you should be able to
>look through and find these numbers (among other things!):

SN raw total sequences: 6910050

SN last fragments: 3455025

SN reads mapped: 5169544

SN reads mapped and paired: 5036738

SN average length: 150

SN maximum length: 150

SN average quality: 35.1

SN insert size average: 241.1

SN insert size standard deviation: 70.9

## Group practical

Now let's take what you've learned and try it out on another dataset! In this example, we will be mapping reads to a Chikungunya virus genome.

To start, navigate to:

``cd /home/manager/course_data/Reference_alignment/07-chikv-align/``

You should see four files:

    annotation.txt

    chikv-genome.fasta

    chikv.read2.fq.gz

    chikv.read1.fq.gz

1. Create a reference index
2. Align the reads to the reference to create a SAM file
3. Convert and sort the SAM file in to a BAM file
4. Index the BAM file
5. Delete the SAM file

**Question 1: How many reads map to the Chikungunya genome?**

**Question 2: What´s the number of unmapped reads?**

**Question 3: What is the insert size average?**
