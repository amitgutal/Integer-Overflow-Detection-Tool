------------------------------------------------------------------------------------------------------------------------

                             INTEGER OVERFLOW EXPLOITIBILITY TOOL (Help File)

------------------------------------------------------------------------------------------------------------------------


      In order to use this tool , make a folder consisting of all your project files and copy paste the Folder into the directory 
      of "INTEGER OVERFLOW EXPLOITIBILITY TOOL".

      After doing this , open terminal window and go to the directory in which the tool is present.   

      Now Run the file ./tool.sh.  This will do. 

      After running this file , IOET will take scan all your C/C++ files.
      
      IOET Will first send these files to Cflow (A GNU Utiltity). Cflow will scanf all .c , .cpp and .h header files and 
 
      accordingly generate a call graph. 
  
      IOET will parse this output and generate a function call information.   
 
      Then it will give you output in the following format. 


-----------------------------------------------------------------------------------------------------------------------
Filename           Function Name         Line Number       Depth           Tainted Variable             Line 
-----------------------------------------------------------------------------------------------------------------------


File Name        : File Name is the name of the file in which the tainted Variable is used which is part of the Overflow. 


Line Number      : Line Number is the line number of the line in which overflow can happen. 


Function Name    : Function Name is the name of the function in which tainted variable is present. 


Depth            : Depth determines the function call depth in the project of the function in which the tainted variable is responsible for overflow
               
                   eg : 3 / 6 .

                   Here 3 is the depth of the function and "6" is the Max Depth in the total function calls.

Tainted Variable : Tainted Variable is the variable which is responsible for the overflow. 


Line             : Line represents the line in the code which may cause the overflow.



license Information for Cflow : 

* Copyright Information:

Copyright (C) 2005, Sergey Poznyakoff 

   Permission is granted to anyone to make or distribute verbatim copies
   of this document as received, in any medium, provided that the
   copyright notice and this permission notice are preserved,
   thus giving the recipient permission to redistribute in turn.

   Permission is granted to distribute modified versions
   of this document, or of portions of it,
   under the above conditions, provided also that they
   carry prominent notices stating who last changed them.

For any bugs mail me : amith222@gmail.com








  