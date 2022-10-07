# BASH scripting
## What is Bash scripting?
A Bash script is a plain text file that contains many lines of Linux commands (e.g. echo, ls,
cp) to be performed in a batch, as opposed to entering each command line individually in
the Linux terminal. Bash scripting could be used to automate multiple or repetitive tasks
on Linux. Bash scripts are written in the Bash programming language, which has its own
syntaxes and structures, including loops, conditional constructions (if...else), and data
containers, comparable to those of other programming languages.
## Bash script execution
A Bash script file must be created and checked for the execution permission status before running. Let´s see how we can do this.
### Create bash script
You can name your script whatever you want but certain
conventions make it a lot easier:
- Avoid adding spaces in the name, use underscore instead
- Use alphanumerical [a-zA-Z0-9]
- Use the extension .sh
 
 *Create and open file “FirstScript.sh:” for editing:*

    nano FirstScript.sh
 
 *An alternative way to create the empty file by using command ``touch`` is:*

    touch FirstScript.sh

A basic script would look something like this:

    #!/bin/bash

    # My first script

    echo "Hello World!"

1. Shebang (**#!**) at the first line of script is used to instruct the OS to use bash as a
command interpreter and specified the path of the interpreter.
2. The line that starts with **#** will not be executed by the interpreter. This line is referred to as
a "comment" and is useful for describing the script.
3. Line of code. This code will print **Hello world** on the screen.

### Set the execution permission
The execute permission of the bash script file can be checked by using ``ls -l`` command.

![image](https://user-images.githubusercontent.com/65819144/194087493-41003d5f-9d17-4d22-9e9d-c2f6cdb60671.png)

In this example, **column 5** lists the size of a file/directory, **column 6** is the
date it was last modified and **column 7** displays the file name.
Additionally, **column 3** lists the user who owns the file and **column 4** shows the group owning the file. **Column 2** represents the number of links to a file.

**Column 1** gives details of file permissions. It consists of 10 characters.
The first character indicates whether a file has a special status. Most
commonly, when the character is a d, this means that the listed file is a
directory. The next nine characters are split into three groups. Characters
2 to 4 indicate permissions for the owner of the file, characters 5 to 7 for
the group owners of the file and characters 8 to 10 indicate permissions
for all other users. 

In each case, if the first character is **r**, this means the user or group of users can **read** the file. If the second character is **w**, this
means that the user or group of users can **write** to the file. Lastly, if the final character is **x**, this indicates that the file is **executable** by that user
(i.e. it is a script or program they can run). Please note that directories are always executable if a user has permission to look at them.

**Question 1: What are the current permissions for the script you´ve just created?**

To change the execute permission, the command ``chmod`` , which is short for “change mode,” will be used.

*Make a script executable:*

    chmod +x FirstScript.sh

![image](https://user-images.githubusercontent.com/65819144/194090824-0ac7e530-3692-4c17-9081-9e9e11fc4160.png)

Now you´ve made your script executable. Let´s see how to run it.

*Run script:* 

    /path/to/file_script.sh

If you are in the directory where the script you want to excute is, type:

    ./FirstScript.sh

> “./” is indicating that the file script is located here

## Variables

Variables are important parts of programing. Using variable names enables you to pass information from the command line into your script and make the script more useful.

### User-Defined Variables

These are the variables created by user. The rules for naming user-defined bash variables are as follows:
- A variable name can include alphabets, digit, and underscore (_). 
- The variable name might be in all CAPS, all lowercase, or a mixture of both.
- The variable name is case-sensitive. For example, “Sequence” and “sequence”
are considered as two separate variables.
- The equal sign (=) is used for assigning a value to a variable. The variable is
located on the left of equal sign while value is on the right. The whitespace
**should not** be added on either side of the equal sign.
- When referring to a previously defined variable, the dollar sign ($) is prefixed to
the variable's name.

Let´s see an example:

    #!/bin/bash

    # My script using variable
    
    myname=$1

    echo "Hello $myname"
    
When we execute this script we´ll see something like this:    
    
![image](https://user-images.githubusercontent.com/65819144/194131423-e5069868-ef43-4c23-96f9-fdf2647794fa.png)

## String manipulation

A string is a combination of a set of characters that may also contain numbers. String Manipulation is defined as performing several operations on a string resulting change in its contents. Bash scripting supports various string manipulations. 

We will be working on a new script called HelloToYou.sh:

    #!/bin/bash

    a="Johann"
    
    b="Mastropiero"
    
    c="$a $b"

    echo "Hello $c"

![image](https://user-images.githubusercontent.com/65819144/194136706-1e0d9d6b-0e41-4d95-9569-87e33bd9d5c9.png)

Bash scripting provides an option to extract a substring from a string (let´s create Substring.sh):

    #!/bin/bash

    filename="SRR19504912_1.fq" 

    # Print string length 
    
    echo ${#filename} 

    # Delete first 3 chars
    
    beg=${filename:3} 

    echo $beg 
    
    # Delete first 3 chars and print 7 chars
    
    mid=${filename:3:7} 
    
    echo $mid 
    
    # Print last 5 chars 
    
    end=${filename: -5} 
    
    echo $end
    
 
 ![image](https://user-images.githubusercontent.com/65819144/194148732-6d39d89b-2522-4f95-8720-c4d7709d5740.png)

What our script is telling us is the following:

    String length= 16

    Substring with first 3 characters deleted= 19504912_1.fq

    Substring with first 3 characters deleted and printing the following 7 characters= 1950491

    Substring printing last 5 characters= _1.fq


Let´s create a new script called GetPairName.sh

    #!/bin/bash 
    
    filename1="SRR19504912_1.fq" 
    
    filename2=${filename1%_1.fq}_2.fq 
    
    echo $filename2 
    
    sample1=sample${filename1#SRR} 
    
    echo $sample1
    
![image](https://user-images.githubusercontent.com/65819144/194152712-2f1a0aeb-abfe-4fb4-8bbe-1b0ecf63bc15.png)

Let´s practice what we´ve learnt until now:

**Exercise 1:** Write a SecondScript.sh that lists (``ls``) the files in your directory

**Exercise 2:** Write a CountScript.sh that counts the lines (``wc –l``) in the file SRR19504912_1.fastq present in /home/manager/course_data/NGS_file_formats_and_data_QC

**Exercise 3:** Modify your SecondScript.sh so that it lists the files in any specified directory as the input to the script. The command line execution would look like:

    SecondScript.sh /path/to/a/directory 
    
>You could try testing this script with /home/manager/course_data as the input to check all the modules you'll be working on during the course.
    
**Exercise 4:** Modify your CountScript.sh so that it counts the lines in any specified file that is the input to the script. The command line
execution would look like:

    CountScript.sh /path/to/a/file
    
>You could try this script with the reference.fasta file in the BASH_scripting directory.    
    
**Exercise 5:** Modify the HelloToYou.sh script so that it takes two arguments (your firstname as $1 and surname as $2) from the command line. Command line execution would be:

    HelloToYou.sh Johann Mastropiero
    
**Exercise 6:** Modify your CountScript.sh file so that it takes the pair of files SRR19504912_1.fastq and SRR19504912_2.fastq (/home/manager/course_data/NGS_file_formats_and_QC) as input and outputs the number of lines in each file.

**Exercise 7:** Modify the GetPairName.sh script so the user can provide any file name as input to the script.

## Condition statement

A condition statement is used for decision making in any programing language. Bash scripting also uses this statement for making some decisions in an automated task.

1. **If statement**

The basic if statement contains one level of condition and action. The syntax consisting of **if** follow by **EXPRESSION** in square brackets. If the EXPRESSION is true, then **ACTION** will be performed. The statement ends with **fi**. If the expression returns false, the script will ignore (i.e. not execute) any code which lies between then and fi.

One if statement can contain one (single condition) or more expressions (multiple conditions).

- Single condition

**Syntax:**

    if [ EXPRESSION ]; then
    ACTION
    fi

The following example shows the basic “if statement” with single condition:

    #!/bin/bash

    #Get input number from user input 
    echo "Enter a number"
    read n

    #Check if input number less than 100
    if [ $n -lt 100 ]; then
      echo "$n is less than 100"
    fi

<img width="1017" alt="image" src="https://user-images.githubusercontent.com/65819144/194428522-2d93bb26-bca1-46bc-887a-bd26467b5223.png">


- Multiple conditions

Multiple conditions in “if statement” need BOOLEAN operator for joining between conditions.

![image](https://user-images.githubusercontent.com/65819144/190713249-9c1dbd69-b842-43cf-b6fc-0fcedb28d0a8.png)

**Syntax:**

*AND operator*

    if [ EXPRESSION_1 ] && [ EXPRESSION_2 ]; then
    ACTION
    fi

*OR operator*

    if [ EXPRESSION_1 ] || [ EXPRESSION_2 ]; then
    ACTION
    fi

The following example shows the basic “if statement” with multiple conditions:

    #!/bin/bash
 
    # Set the path for our file

    file="reference.fasta"
 
    # Check whether file exists, is readable and has data

    if [[ -e ${file} ]] && [[ -r ${file} ]] && [[ -s ${file} ]];then
    	 # Execute this code if file meets those conditions
    	 echo "File is good"
    fi
    
<img width="1066" alt="image" src="https://user-images.githubusercontent.com/65819144/194431634-8c56af71-4cbd-4488-aacb-d0389185a7a2.png">

2. **If-else statement**

We can extend our conditional statement to have another clause by using an **if..else statement**. Here we are saying, **IF** our conditions are met, **THEN** execute the following commands. However, **ELSE IF** these conditions are not met, execute a different set of commands.

**Syntax:**

    if [ EXPRESSION ];then
    ACTION_1
    else
    ACTION_2
    fi

Here's an example: 

    #!/bin/bash
    
    a=$1
    if [ "$a" == "Johann" ];then
      echo "Hello again Johann"
    else
      echo "Unrecognized name"
    fi
    
<img width="700" alt="Screen Shot 2022-10-06 at 19 44 55" src="https://user-images.githubusercontent.com/65819144/194432025-cc9a07bd-0c62-473b-8a66-f1969ed4a8a6.png">


## For loop

Loops allow us to take a series of commands and keep re-running them until a particular situation is reached. They are useful for automating repetitive tasks.

Basically, what the **for loop** does is say for each of the items in a given list, perform the given set of commands. For loop starts with **do** and
ends with **done**. Let's take a look at its syntax:

     for ITEM in LIST
     do
       ACTION
     done
 
First, let's create a new folder with some fastq files you've worked with in previous modules:

    mkdir fastq_sets
    cd fastq_sets
    ln -s /home/manager/course_data/NGS_file_formats_and_data_QC/SRR19504912_*.fastq .
    
Now let's create a for loop that will print the names of all the files in the fastq_sets directory and the number of lines in each file:

    #!/bin/bash
    for f in *.fastq
    do
    echo $f
    wc -l $f
    done
    
<img width="699" alt="Screen Shot 2022-10-07 at 13 07 39" src="https://user-images.githubusercontent.com/65819144/194598776-061873ca-a78a-456c-837e-fd15e0b5bffc.png">

> The asterisk (\*) works as a wildcard, i.e. a character that can be used as a substitute for any of a class of characters. Here we are using the wildcard to use in our script all the files with a particular extension (.fastq).

**Exercise 8:** Use your GetPairName.sh script as the base for a new one  that will check with an (if) that the input file has \_1.fastq (end=${filename: -8}) and only then print out the paired sample name.

>Create this script using the files in the fastq_sets directory.

**Exercise 9:** Write a script called Loop2.sh to loop (for) through the
directory fastq_sets and copy (cp) the files to your current
directory.

**Exercise 10:** Modify your Loop2.sh script so that the files are
renamed from .fastq to .fq
 
**Exercise 11:** Modify your CountScript.sh so that it loops through
the fastq_sets directory (for) and if the file has \_1.fq
(end=${filename: -5}), it counts the number of lines in the file
(``wc –l``).




