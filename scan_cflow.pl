#!usr/bin/perl;

use strict;
use warnings;
	
use File::Find;

opendir(DH,".");							
my @directories_to_search=readdir(DH);						# Reads the directory contents.
my $current_dir="";

my @dir_curr;
my $ind=0;
my $all_files="";



foreach my $arr(@directories_to_search)
{
  if($arr eq "." | $arr eq "..")
  {
       $arr="";
       
       # shift@directories_to_search;
  } 
else
{  
   $dir_curr[$ind] = $arr;
   $ind++;
   
}
}

#print "--------------------\n";

foreach my $arr(@dir_curr)
{
  # print "$arr\n";

}

#print "--------------CODE TO FIND C/C++/Header Files and pass them to CFLOW  ------\n";

   find(\&wanted, @dir_curr);


    sub wanted 
    { 
       if($File::Find::dir eq "" | $File::Find::dir eq "")
     { 
      #   print "\n $File::Find::name";
     } 
   else 
  { 
       #  print "$File::Find::dir \n";
         my $file_ext1 = substr($File::Find::name,-2); 
         my $file_ext2 = substr($File::Find::name,-3);
         my $file_ext3 = substr($File::Find::name,-4);
         
	 if($file_ext1 eq ".c" | $file_ext1 eq ".h" | $file_ext2 eq ".cc" | $file_ext3 eq ".cpp")
         {  
        #    print "\n $File::Find::name \n";
            $all_files=$File::Find::name." ".$all_files; 
         }  
    }
  }
      
#      print $all_files."\n";
      
#      cflow --level begin=$ --level '0=$' --level '1=$' --level end0='$' --level end1='$'


if(@ARGV)
{ 
  my @result1 = `cflow -m ,--main=@ARGV -l -b --omit-arguments $all_files > a1.txt`;   

   my @result = `cflow -m ,--main=@ARGV --format=posix  -b --omit-arguments --no-number --level-indent 5 --level begin=  --level '0= ' --level end1='#'  --level end0='\$' $all_files > amit.txt`;         # CATCH CFLOW OUTPUT 

}

else
{

my @result1 = `cflow -l -b --omit-arguments $all_files > a1.txt`;   



my @result = `cflow --format=posix  -b --omit-arguments --no-number --level-indent 5 --level begin=  --level '0= ' --level end1='#'  --level end0='\$' $all_files > amit.txt`;         # CATCH CFLOW OUTPUT 
}



