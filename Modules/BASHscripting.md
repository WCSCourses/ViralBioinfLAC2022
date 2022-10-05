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
    
When we execute this command we´ll see something like this:    
    
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











This section will show the example of string operation Length, Substring, and Find and Replace.

### String Length
There are many ways to calculate the string length:
1. A simple way to calculate the length of the string is to use # symbol.

**Syntax:**

``$[#string_variable_name]``

2. Calculate the length of the string using an ``expr`` command with an option “length”.

**Syntax:**

``expr length “$string_variable_name”``

3. Use an ``awk`` command to calculate the length of the string

**Syntax:**

``echo $string_variable_name | awk ‘{print length}’``

![Imagen1](https://user-images.githubusercontent.com/65819144/190473883-681370a6-e090-454e-9e47-d2d3dbce5731.png)

### Substring

Bash scripting provide an option to extract a substring from a string.

**Syntax:**

``${string:position:length}``

This means that we will extract **Length** characters of substring from **String** at **Position**.

- Example 1: *Extract substring from start until specific length*

![Imagen2](https://user-images.githubusercontent.com/65819144/190475217-a354438f-b8ba-4234-a5ac-9eb2ae5cff66.png)

- Example 2: *Extract substring from specific character onwards*

![image](https://user-images.githubusercontent.com/65819144/190475700-0639ab59-86b9-4c91-ab99-1093482a2b45.png)

- Example 3: *Delete the first 3 characters and then print 12 subsequent characters*

![image](https://user-images.githubusercontent.com/65819144/190475927-93f0773b-a33c-42d2-b30d-43e5e823ddee.png)

- Example 4: *Extract a specific number of characters counting from the end of the string*

![image](https://user-images.githubusercontent.com/65819144/190476120-43c4983f-1b28-4b4e-9c78-07174f3777c1.png)

### Shortest (non-greedy) substring match

The syntax for deleting the shortest match of the substring from the string

*Delete matched substring from the beginning of string*

**Syntax**

``${string#substring}``

*Delete matched substring from the end of string*

**Syntax**

``${string%substring}``

![image](https://user-images.githubusercontent.com/65819144/190481902-b85c0e72-8aed-46a3-8ca6-9e777b4b8d6d.png)

### Longest (greedy) substring match

The syntax for deleting the longest match of substring from string

*Delete match substring from the beginning of string*

**Syntax:**

``${string##substring}``


*Delete match substring from the end of string*

**Syntax:**

``${string%%substring}``

![image](https://user-images.githubusercontent.com/65819144/190486117-f1003cec-e155-4b36-b3fe-a5ca0ceef148.png)

### Find and replace

1. Replace only the first match

*Find the pattern in string and replace only the **first match** by replacement.*

**Syntax:**

``${string/pattern/replacement}``

![image](https://user-images.githubusercontent.com/65819144/190486468-d2a7f63f-690a-4f9a-a42b-ed8b58a92092.png)

2. Replace all the matches

*Find the pattern in string and replace **all matches** by replacement.*

**Syntax:**

``${string//pattern/replacement}``

![image](https://user-images.githubusercontent.com/65819144/190487552-7a791bd1-abf0-450b-b17d-0b5e850167d1.png)

3. Replace at the beginning or the end

Find the pattern in string and replace only first matched pattern with the replacement from the beginning of the string

**Syntax:** 

``${string/#pattern/replacement}``

Find the pattern in string and replace only first matched pattern with the replacement from the end of the string

**Syntax:**

``${string/%pattern/replacement}``

![image](https://user-images.githubusercontent.com/65819144/190488676-603cc2af-fc00-473b-a78d-0c9956f1966c.png)

## Arrays

An array is a data container comprised of two parts including keys and values.

- Create indexed or associative arrays using ``declare`` command

**Syntax:**
   
   1. Bash indexed array: the keys of array are ordered integers.

    declare -a array_name
    array_name=(value1 value2)
    
   2. Bash associative array: the keys of array are strings.
    
    declare -A array_name
    array_name=(["key1"]="value1" ["key2"]="value2")
    
- Access values of an array
1. Access all data in the array
    
    ``${array_name[@]}``

2. Show all index of the array

   ``${!array_name[@]}``

3. Access to the data of the index n of the array

   ``${array_name[n]}``

4. Show the length of the array

   ``${#array_name[@]}``

5. Remove both index and data at the index n

   ``unset array_name[n]``

6. Add new data to the array at the index n

   ``array_name[n]=”new_value”``

![image](https://user-images.githubusercontent.com/65819144/190681882-230477b8-0a0d-440e-a616-2eaeb65c2205.png)

## Arithmetic operators

Arithmetic operator is a mathematical function that is used to perform an arithmetic operation. The following 11 arithmetic operators are supported by bash:

![image](https://user-images.githubusercontent.com/65819144/190692679-7dc961fc-dfac-4b94-94d7-d10874e6ae95.png)

Double parentheses can be used to specify arithmetic operation in Bash.

**Syntax:**

``((expression))``

![image](https://user-images.githubusercontent.com/65819144/190692955-f3efec80-aa3c-4598-926b-d9ec8bcd5394.png)

## Script Input (STDIN)

1. Command line arguments

The arguments are input that necessary for processing the script. The command line arguments are passed in a positional way.

**Syntax:**

```
./bash_script.sh arg1 arg2 arg3..

where arg1 = $1 arg2 = $2 arg3 = $3
```

![image](https://user-images.githubusercontent.com/65819144/190710136-690f82f4-7934-4ae6-8ffc-0114ac0fe73e.png)

2. Read command

A ``read`` command is built-in command that takes the user input into a variable.

**Syntax:**

```
read OPTIONS ARGUMENT
```

![image](https://user-images.githubusercontent.com/65819144/190711672-8c7e90df-ecfe-4bf2-a19b-566fe3a9dc2b.png)

## Condition statement

A condition statement is used for decision making in any programing language. Bash scripting also use this statement for making some decisions in an automated task.

Comparison operators

![image](https://user-images.githubusercontent.com/65819144/190711894-8c3cb573-6326-4291-8fff-02e7ba5ab3c9.png)

1. **If statement**

The basic if statement contains one level of condition and action. The syntax consisting of **if** follow by **EXPRESSION** in square brackets. If the EXPRESSION is true, then **ACTION** will be performed. The statement ends with **fi**. One if statement can contain one (single condition) or more expressions (multiple conditions).

- Single condition

**Syntax:**
```
if [ EXPRESSION ]; then
ACTION
fi
```

The following example shows the basic “if statement” with single condition:

![image](https://user-images.githubusercontent.com/65819144/190712412-0ba25622-843f-4425-b7d5-175894082593.png)

- Multiple conditions

Multiple conditions in “if statement” need BOOLEAN operator for joining between conditions.

![image](https://user-images.githubusercontent.com/65819144/190713249-9c1dbd69-b842-43cf-b6fc-0fcedb28d0a8.png)

**Syntax:**

*AND operator*

```
if [ EXPRESSION_1 ] && [ EXPRESSION_2 ]; then
ACTION
fi
```

*OR operator*

```
if [ EXPRESSION_1 ] || [ EXPRESSION_2 ]; then
ACTION
fi
```

The following example shows the basic “if statement” with multiple conditions:

![image](https://user-images.githubusercontent.com/65819144/190713691-2c53de70-e287-42c3-a1be-7253be62d140.png)

2. **If-else statement**

This pattern of conditional statement is used to execute one action with a true condition and the other action with a false condition.

**Syntax:**
```
if [ EXPRESSION ]; then
ACTION_1
else
ACTION_2
fi
```

![image](https://user-images.githubusercontent.com/65819144/190714186-69a01fa9-6c62-4ad9-bc0c-fb29bf78b446.png)

3. **If..elif..else statement (if-else in ladder)**
