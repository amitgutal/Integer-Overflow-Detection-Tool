#! usr/bin/perl;

use strict;


## ----------------------------------- CODE AFTER CFLOW EXECUTED ---------------------------- ###


##--------------------------- READING THE CFLOW FILE GENERATED ---------------- ####


my $filename1 = "amit.txt";				# Output stored into this file.		
open my $fo, '<', $filename1 or die "Could not open file";       # Page 95 Ebook        
my $sum =0;

my $exp;

my $file_name;
my $line_no; 

my $file2 = "temp.txt";				# Output stored into this file.		
open my $fw, '>', $file2 or die "Could not open file";       # Page 95 Ebook        


# print "Function Name:    FileName   Line NO";

while(my $line = <$fo>)              ######## CODE TO REMOVE DUPLICATE ENTRY IN CFLOW  ############
{
   if($line =~/:.[0-9]+/) 
    {
          
#	   chomp $line;
	    
            my ($op1,$op2) = split ":",$line;
	    
            my $count =0;
	    my $file1 = "amit.txt";				# Output stored into this file.		
            open my $ft, '<', $file1 or die "Could not open file";       # Page 95 Ebook    
	    my $lin;
	  
	   my $blank_str='';    
	  
	  while($count != $op2 and $lin = <$ft>)
	  {
	        $count ++ ;
	  }
	  
	 
	 my ($s1,$s2) = split '\$',$lin;                      
	 my ($ss1,$ss2) = split '#',$lin;

	 
#W	 print "New :$s2\n";
#	 print "New S:$ss2\n"; 
	#  my $index1 = rindex($line,"\$");
	  
	  my $index1 = -1;
	  my $index2 = -1;
	  
	   $index1 = rindex $line,"\$";
	   $index2 = rindex $line,"#";
	  my $new_cnt = 0;
	  
	  my $b_str = '';
	  if($index1 != -1)
	  {
	     while($new_cnt != $index1) 
	     {
	         $b_str=$b_str." ";
		 $new_cnt++;
	     } 
         
	  if($s2) 
             {
	          print $fw "$b_str\$".$s2;
	     }           
	    if($ss2) 
	     {
	          print $fw "$b_str"."\$".$ss2;
	     }           
	    

	  }    
	  
	  
	  #--------------------------------------# 
	  $b_str='';
	    if($index2 != -1)
	  {
	     while($new_cnt != $index2) 
	     {
	         $b_str=$b_str." ";
		 $new_cnt++;
	     } 
          if($s2) 
             {
	          print $fw "$b_str"."#".$s2;
	     }           
	    if($ss2) 
	     {
	          print $fw "$b_str"."#".$ss2;
	     }           
	    

	  }   
#	  print "Count : $count Line: $lin\n";
#	  print "Curr Line : $line\n";    
	  
	  
	  
	
close $ft;    	    
   }
   
    else
     {
       print $fw $line;
     }	
           
    
}    
 

close $fw;
close $fo;



#########################################  CODE TO ADD "?" To a Recursive Call in the Function
my $count =1;

      # CATCH CFLOW OUTPUT 
my $yup1=0;

my $file_1 = "a1.txt";				# Output stored into this file.		
open my $file_ptr, '<', $file_1 or die "Could not open file";       # Page 95 Ebook    

my $temp=0;

my @recur_line;

while(my $line = <$file_ptr>)
{
     if($line =~/.(recursive:)/)        # Removing Recursion
     {
         $recur_line[$temp] = $count;                   # Checking for Recursion
	 #print $recur_line[$temp]."\n";     
         $temp++;
     }
        $count++;
}

my $f2 = "temp.txt";				# Output stored into this file.		
open my $fpt2, '<', $f2 or die "Could not open file";       # Page 95 Ebook    

my $f1 = "new_temp.txt";				# Output stored into this file.		
open my $fpt1, '>', $f1 or die "Could not open file";       # Page 95 Ebook    


$temp=0;

$count=1;

while(my $read = <$fpt2>)
{
    if($count eq ($recur_line[$temp]))
       {
           #print $read;
           $temp++;
      }  
    else
    {
           print $fpt1 $read;	   
    }  
    $count++;   
}

close $fpt1;
close $fpt2;
close $file_ptr;









######################################### 

##--------------------------- READING THE CFLOW FILE GENERATED ---------------- ####

my $file1 = "new_temp.txt";				# Output stored into this file.		
open my $fo1, '<', $file1 or die "Could not open file";       # Page 95 Ebook 



my $tmp_file = "pat_temp.txt";				# Output stored into this file.		
open my $f_tmp,'>', $tmp_file or die "Could not open file";       # Page 95 Ebook 


while(my $line = <$fo1>)
{
  if($line =~/<.*[a-zA-Z0-9]>/  or $line =~/.+[a-zA-Z](?=:.+[0-9])/) 
   { 
      #  my ($fname,$sname) = split /~<.*[a-zA-Z0-9]>/ , $line;
     my ($fun_name,$tmp) = split /:/,$line;
   #   my ($f,$sname) = split /\),/, $line;                       # Chap. 5 Regular Expression
   #  my ($file_name,$line_no) = split / /,$sname;
   #----------------------------------------------------------------------------------------------
    # IF which Extracts File Name and Line No. from the temp.txt File and prints it to pat_temp.txt
       if($line =~/<.*[a-zA-Z0-9]>/)      
       {	
#            print $line;
   
	    my ($f,$sname) = split /,/,$line;
        #    print $sname; 	 
	    chomp $sname;      
	    my $len = length($sname);
	    my $f_index = rindex $sname,"<";
	    my $f_index1= rindex $sname,">";	    
#	    print "S:Name : $sname\n";
#	    print "Length : $len\n";
	 #   print "Index > : $f_index1\n";
 	    my $file_info = substr($sname,$f_index+1,$f_index1-2);
	    my ($fil_name,$lin_no) = split " ",$file_info;
                $file_name = $fil_name;
	        $line_no = $lin_no;
      }   
if($line =~/\?/)
 {
   print $f_tmp "$fun_name $file_name $line_no ?\n";
 }
 else
 {
   print $f_tmp "$fun_name $file_name $line_no\n";
 }
#    print "$fun_name $sname\n ";
 # print "$file_name $line_no\n";
# print $line;
    }
    
}
close $f_tmp;









##while(my $line = <$fo>)
##{
 ## if($line =~/<.*[a-zA-Z0-9]>/  or $line =~/.+[a-zA-Z](?=:.+[0-9])/ ) 
  ##  { 

      #  my ($fname,$sname) = split /~<.*[a-zA-Z0-9]>/ , $line;
      
   ##  my ($fun_name,$tmp) = split /:/,$line;
     
  #   my ($f,$sname) = split /\),/, $line;                       # Chap. 5 Regular Expression
##
   #  my ($file_name,$line_no) = split / /,$sname;


     ##  if($line =~/<.*[a-zA-Z0-9]>/)     
      ## {
        ##    my ($f,$sname) = split /\),/, $line;
#	    print $sname;
	##    chomp $sname;
	  ##  my ($fil_name,$lin_no) = split " ",$sname;
	
##               $file_name = $fil_name;
	##       $line_no = $lin_no;
 ##      }   

## print "$fun_name $file_name $line_no\n";

#    print "$fun_name $sname\n ";
   
#  print "$file_name $line_no\n";

# print $line;
   ## }
##}




