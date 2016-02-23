#!usr/bin/perl;
# use strict;
#use warnings;
my $out_file = "out.txt";				# Output stored into this file.		

open my $out_temp,'<', $out_file or die "Could not open file";       # Page 95 Ebook 
 
my $file = "./output.txt";						
open my $outputfile, '>', $file or die "Cannot not open file";              

   my $cnt =0;
   my $brace_cnt=0;
 
my @fun_enter;
my @start_of_function;
my @file_name_ary;

my $depth = 0;
my $tnt_tracker = 0;

         # Used to Check Multiple Function CALLS 

my $taint_track_index;
my @tainted_variables;

my $tmp_counter= 0;

my $new_flag =0;

##################### Adding Function Names ###########################
while(my $line_out1 = <$out_temp>)
{
    
       my ($file_name , $fun_name , $start , $end) = split ' ',$line_out1;
       
       if($new_flag eq 0)
       { 
          $fun_enter[$tmp_counter] = $fun_name;
	  $start_of_function[$tmp_counter] = $start;
	  $file_name_ary[$tmp_counter] = $file_name;
	  $new_flag = 1;
       } 
       
	$tmp = 0;
	
	
	my $tot_flag = 0;
	my $flg = 0;
	
	while(($flg eq 0) and $tmp < $tmp_counter)
	{
	     if($fun_name eq $fun_enter[$tmp])
	     {
	     
	          $flg = 1;
    
                  $tot_flag = 1;
    
#	         print $fun_name;	       
	     }
    
	 $tmp++;
	}
	
	
	 if($tot_flag eq 0)
	    {

                  $fun_enter[$tmp_counter] = $fun_name;
		  $start_of_function[$tmp_counter] = $start;
		  	  $file_name_ary[$tmp_counter] = $file_name;
	          $tot_flag = 1;
	#          print  $fun_enter[$tmp_counter]."\n";		  
                  $tmp_counter++;	
	    }

#print @fun_enter;
#print "\n";

}
################################################

my $out_f = "out.txt";				# Output stored into this file.		

open my $out,'<', $out_f or die "Could not open file";       # Page 95 Ebook 


while(my $line_out = <$out>)
{
	my ($file_name , $fun_name , $start , $end) = split ' ',$line_out;
	
#	print "------------Entering $file_name  $fun_name--------------------\n";#
#	print "$file_name\n";
#	print "$fun_name\n";#
#	print "$start\n";#
#	print "$end\n";
#	print "---------------------------------\n";
	
       $tag =0;
my $flag_in = 1;
my $tnt =0;

while($fun_enter[$tnt] and $flag_in eq 1)         ## Go TO Particular Function and byt Taint_track_index
{
    if($fun_name eq $fun_enter[$tnt])
    {
      $flag_in = 0;
      $taint_track_index = $tnt;     
    }

$tnt++;
}   

  

open my $src_file,'<',$file_name  or die "Could not open file";       # Page 95 Ebook 
	 
my $counter=1;

my $cnt;
my $fnm;
my @fun;
my $cmd;

	  while($counter < $start and my $input = <$src_file>)
	   {
	           $counter++;
#                  print $line;
	   }
	   
	   $counter--;
	# print "------------ Enter Function : $fun_name ----- $fun_enter[$taint_track_index];--------------\n\n" ;    
   while($counter <= $end and my $input = <$src_file>)
     {
############################# SCANNING FUNCTIONS FOR FILES ##########################################################################
  
	
	#print $input; 
        $cnt ++;
	chomp $input;
     
   
# If it is main() function.
          #--------------------------------------------------------------------
	  
	  if($input =~/main\((.*),(.*)\)/)
	  {
		$f=$2;
		#chomp $f;
	        
        	#print $input;
		# print "Main Found ###############################################";
		 #print $1 , $f."\n" ;
		if($1=~/\s*int\s+(.*)/)
		{
		    $tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$1,";
		    print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
		    
		}
		
		if($f=~/\s*char\s+(\*)*([.A-Za-z0-9_]*)(\[\])*/)     ### IT's For character
		{
		  
            	        $temp =$2;
			chomp $temp;
			#print $2;
               		$tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			#exit(0);
                        print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
        
		
		}
	   
	
	}
          #--------------------------------------------------------------------                # Following  determines, which statment belongs to which function.  
	
	 # Check for command input argument value which is taken in a  variable.
	 #print $cmd;
	 
	#	if($input =~ /\s*(.*)=$cmd(\[[0-9]*\])/)
		#{
			#print $outputfile "$file_name $counter $depth  $1-    $fnm-\n";
	#	}
	


	if($input=~ /(.*)\s*=\s*getchar\(\)/)
	{
	                 		 
                 	$temp =$1;
			chomp $temp; 
                 	##################################################################################### 
                                  
                        $tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
         
                        #####################################################################################

                        print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
                        
        }





	# For scanf
	
	if($input =~ /scanf\("(.*)*"(,)(.*)*\)/)
	{ 


	        if($input=~ /\("(.+)"((,)(.*))\)/)
	        {
		                      
		      
		       my $temp = $2;
		       chomp $temp;
		       my @temp_var = split/&/,$temp;
		      
		    #  print @temp_var; 	 
				
			    
		 $tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."@temp_var,";			
            		    print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
			 
			##################################################################################### 
                                  
                            
                                  
                        #####################################################################################

               #         print $outputfile "$file_name $counter $depth $tainted_variables[$taint_track_index]\n";
                                  
                }
	}



#	if($input =~ /(.*)\s*=\s*fopen\((.*),(.*)\)/ )#
#	{
#		print $outputfile "\n fopen:   $cnt - $newarr -   $1  $2  $3   $fnm \n ";#
#	}


		if($input=~ /(.*)\s*=\s*fgets\((.*),(.*),(.*)\)/)
		{
		
		        ##################################################################################### 
                                  
                         $tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$1,$2,$3,$4,";
                                  
                        #####################################################################################
       
		         print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
		
		
#			print $outputfile "$file_name $counter $newarr -  $1   $2     $3   $4      $fnm -- \n";  
		}
	        if($input=~ /(.*)\s*=\s*gets\((.+)\)/)
	
		{
                        $temp =$1;
			if($temp =~/int\s+([A-Za-z0-9_]+)/)
			{
			   $tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$1,";
			
                           print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
			}
			else
			{
               		   $tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			
                           print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
			}
		}

	if($input=~ /(.*)\s*=\s*getc\((.+)\)/)
	{
                        $temp =$1;
			chomp $temp;
			
               		$tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
						
                        print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
	}
	
                if($input =~ /(.*)\s*=\s*socket\((.*),(.*),(.*)\)/ )
		{
			#print "\n $count - $arra - $fnm -socket- " , $1, " - ",$2," - ",$3," - ",$4, "\n";
			 $temp =$1;
			chomp $temp;
			
               		$tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
		}
		
		
		if($input =~ /(.*)\s*=\s*listen\((.*),(.*)\)/ )
		{
			
			# print  "\n $count - $arra - $fnm -listen- ",$1, " - ",$2," - ",$3,"\n";
			
			# print "\n $count - $arra - $fnm -socket- " , $1, " - ",$2," - ",$3," - ",$4, "\n";
			 $temp =$1;
			chomp $temp;
			
               		$tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
			
		}
		if($input =~ /(.*)\s*=\s*accept\((.*),(.*),(.*)\)/ )
		{
			# print "\n $count - $arra - $fnm -accept- ",$1, " - ",$2," - ",$3, " - ", $4,"\n";
			
			# print "\n $count - $arra - $fnm -socket- " , $1, " - ",$2," - ",$3," - ",$4, "\n";
			$temp =$1;
			chomp $temp;
			
               		$tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
			
		}
		if($input =~ /(.*)\s*=\s*recv\((.*),(.*),(.*),(.*)\)/ )
		{
                        # print "\n $count - $arra - $fnm -socket- " , $1, " - ",$2," - ",$3," - ",$4, "\n";
			 $temp =$1;
			chomp $temp;
			
               		$tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";

			# print "\n $count - $arra - $fnm - recv - " , $1, " - ",$2," - ",$3," - ",$4, " - ",$5,"\n";
		}
		
		
		
		if($input =~ /(.*)\s*=\s*gethostbyname\((.*)\)/ )
		{
		
		# print "\n $count - $arra - $fnm -socket- " , $1, " - ",$2," - ",$3," - ",$4, "\n";
			$temp =$1;
			chomp $temp;
			
               		$tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
		
			# print   "\n $count - $arra - $fnm -gethostbyname- " , $1, " - ",$2,"\n";
		}
		#######################################
		
			
			if($input=~/(.*)(\s*)(=+)(\s*)memset\($variable\)/)
			{
			# print $input;
			}
			if($input=~/(.*)(\s*)(=+)(\s*)sscanf\($variable\)/)
			{
			 #print $input;
			}
		
##################################################################################################################################### 
#####################################################################################################################################
#####################################################################################################################################
#####################################################################################################################################
#####################################################################################################################################
#####################################################################################################################################


####################################### Checking Current Tainted Variables and then Splitting them 
      chomp $tainted_variables[$taint_track_index];
      
    #  print $tainted_variables[$taint_track_index]."\n";
      
      my $yahoo = $tainted_variables[$taint_track_index];
      
   #   print "-----\n";
      
      $tainted_variables[$taint_track_index]=~s/\s*(,)+\s*/,/g;       # Pattern to remove white spaces in tainted Variables
      
    #  print $tainted_variables[$taint_track_index]."\n";
	      
   # print $tainted_variables[$taint_track_index]."\n";
      my (@new_tainted_variables) = split ",",$tainted_variables[$taint_track_index];

####################################### Checking Current Tainted Variables and then Splitting them   



my $tmp_func_name;
		
#########################################################################  
      my $var = 0;
 #     print @new_tainted_variables;
   #   print "\n";
   #   print "----------------------------------\n";
####################### CODE TO CHECK IF SET OF TAINTED VARIABLES IN A PARTICULAR LINE PERFORM SOME OPERATION ###########        
      
      my @temporary_function;
     
      
foreach $var(@new_tainted_variables)
    {
         chomp $new_tainted_variables[$var];
         chomp $var;
	 my $variable = $var;
 
# print @new_tainted_variables;
#	print "\n";
	# print "------------------------$var\n";
	#print $outputfile "------------------------\n";
#	if($input=~/\s*([A-Za-z0-9_]+)\s*=+$variable/gx)
#################### Please NOTE ############################

#     This is important Regular Expression Checkin in which a pArticular Tainted VAriable which is coming from outside the program
#     which is checked so that other variables which are affected by it are Also Added as TAINTED.
#  THE REGULAR EXPRESSION WHICH IS IMPLEMENTED IS  not Working Properly 
# have to Add many Constraints  
#     
####################### PLEASE NOTE #########################

### SOME Functions shud be tested for Tainted Variables input such as strlen(const char *); 
### which takes the input as tainted variable and the output a tainted variable.
###  

  
  if($input=~/(\s*)memcpy(.*),(.*),(.*)/)
  {
      #  print $input;
  }
  

if($input=~/\s*([.A-Za-z0-9_]*(\->)*[.A-Za-z0-9_]*)\s*(=+)\s*(.*)\(*$variable(.*)\)*/)  # Tainted PAttern Found in a Function. 
{

#  print "\n*************************************$input";
########## Code to check for Tainted Variable which are passed as an arguments to other know functions by  Cflow and
########## mark them as tainted in Respective Function Call.

my @temp_ary = @fun_enter;
my $fun_index = 0;
#print @temp_ary;
my @index_storage_ary;
my $storage_index = 0;

#print "\n ------------\n";

while($fun_index < @temp_ary)
 {
#  print $fun_enter[$fun_index];
#  print "\n";
 # print $tainted_variables[$tmp_variable]."\n";

  my $tmp_fun_name = $temp_ary[$fun_index];
 
  my $temporary=0;
 
 # print $input;
 # print "\n$tmp_fun_name\n";

#  print "\n $counter \n";


##################################################################################################### I

if($input=~/(\s*)(\s*)(\s*)$tmp_fun_name\(+(.*)\)+\s*/ or $input=~/(\s*)(=+)(\s*)$tmp_fun_name\(+(.*)\)+/)
{
  
   #print $tmp_fun_name."\n";
   #print "--- $counter \n";
   #print "--- $input \n";
  #print "########## Important Regular Expression which check for Function Call which is called by Tainted Data ";       
   #   $temporary_function[$temporary] = $tmp_fun_name;
  
  #    print $temporary_function[$temporary]."----\n";
      
   #   $temporary++;  
       
  
    


# print $input."\n";		
#print $tmp_fun_name;
	# print "\n -------------$4--------\n" ;
	
	# print "\n";

	$local = $4;
        my @fun_taint = split ",",$local;

	#print @new_tainted_variables;	     #  print @fun_taint;
		       #	print "\n";
	my $fun_taint_index =0;

	
	#print  @fun_taint;
	
	while($fun_taint_index < @fun_taint)
	{
	   #   chomp $fun_taint_index; 
		    #   print "fun Taint : $fun_taint[$fun_taint_index]";
		     #   print "\n";
		#	print "-------\n";
	      #print $fun_taint_index."\n";
	     #s print "\n";
	    	my $index_taint =0; 
	     while($index_taint < @new_tainted_variables)
	          {

                       #   print @new_tainted_variables;
		  #     print "\n";
		    #   print "Tainted Array :".$new_tainted_variables[$index_taint];
		     #  		       print "\n";
		       
	               if($fun_taint[$fun_taint_index] eq $new_tainted_variables[$index_taint])
		       {
		            $index_storage_ary[$storage_index]=$fun_taint_index;
			    $storage_index++;
			    
			  #  print "$fun_taint[$fun_taint_index]\n";
			  #  print "$new_tainted_variables[$index_taint]\n";
			    
			    
		       } 	   
	
	             $index_taint++;
	            }
	  $fun_taint_index++;	      
	}
	
			     my $ot_file = $file_name_ary[$fun_index];					

                             open my $t_temp,'<', $ot_file or die "Could not open file";       
			     
			     ## Open the particular file and check for Function Defination
                              my $ty_count=0;
			     my $line_function;
                             while($ty_count < $start_of_function[$fun_index] and $line_function = <$t_temp>)
			     {
			           $ty_count++;
			           
			     } 
	                      # print $line_function;
			       

			       if($line_function =~/\s*(int|float|char|struct|void|\b*)+(\s*\*|\s*)+[a-z|A-Z_]+\((.*)\)\s*/)
			       {
#			         print $line_function;
	#			 print $3;
				 my $temp = $3;
				 my @ind =  split ",",$temp;
				 my $gind =0;
                                 while($gind < @ind)
				 {
				     
				     my $rt = $ind[$index_storage_ary[$gind]];
				    # print "\n@@@@@@@@@@@@@@@@@@ $rt\n";
				     
				     my @ty = split " +",$rt;
				     
				      my $p=$ty[$#ty];  ### Function Called and Called VAriable type extracted
				    # print "\n";
				    # print $temp_ary[$fun_index]."\n";
				     
				     $tainted_variables[$fun_index] = $tainted_variables[$fun_index]."$p,";
				     
				     print $outputfile "$file_name_ary[$fun_index] $tmp_fun_name $ty_count $depth $tainted_variables[$fun_index]\n";
				     
				     $gind++;
				 
				 } 
				 					 
			       }
			       #print $fun_enter[$fun_index]."\n";
	                       #print $start_of_function[$fun_index]."\n";
	                       #print $file_name_ary[$fun_index]."\n";
			      
 }

  $fun_index++;

}
	################ PATTERN MATCHING CHECK FOR TAINTED VARIABLE AFFECTING OTHER TAINTED VARIABLE 
	    
	                 
		  #      print $1."\n";
		  
		  #print $variable."\n";
   		     if($input=~/\s*([.A-Za-z0-9_]*(\->)*[.A-Za-z0-9_]*\+*)\s*(=+)\s*(.*)([\+-\\\*]+)\s*($variable)\s*([\+-\\\*]+)(.*)/)  # Tainted PAttern Found
		     {
	#	         print $input;
		     }
		     if($input=~/\s*(strcpy)\s*(\($variable\))*/)  # Tainted PAttern Found
		     {
                       print $1;
		     }
		     
		     
	                
		     if($input=~/(.*)(\s*)(=+)(\s*)(atoi)\(+$variable\)/)
			{
			            $temp =$1;
			            chomp $temp;
					my $multi_flag =0;
					my $new__var = 0;
			
		foreach $new__var(@new_tainted_variables)
			{
			#print $new__var."\n";
			#print $temp."\n------------------\n";
				      if($temp eq $new__var)
				      {
			                      $multi_flag = 1;
				              print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
			               }
			      
			}
			      if($multi_flag == 0)
			      {
			
			         $tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			          print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
		              } 	         
			}
			
			
			$temp =$1;
			chomp $temp;
			######################## CHECK FOR MULTIPLE TAINTED VARIABLES 
			my $multi_flag =0;
			my $new__var = 0;
			
			foreach $new__var(@new_tainted_variables)
			{
			#print $new__var."\n";
			#print $temp."\n------------------\n";
			      if($temp eq $new__var)
			      {
			          $multi_flag = 1;
				  print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
			      }
			      
			}
			if($multi_flag == 0)
			{
			
			  $tainted_variables[$taint_track_index] = $tainted_variables[$taint_track_index]."$temp,";
			  print $outputfile "$file_name $fun_name $counter $depth $tainted_variables[$taint_track_index]\n";
		        } 	         
              	
			######################## CHECK FOR MULTIPLE TAINTED VARIABLES 			
			
	    } 
       } 	 
      @new_tainted_variables = split ",",$tainted_variables[$taint_track_index];
   
   #   print "----------------------------------\n";
      
#######################  -----------   END   ------------------------------ ###########################################      
      
      
       # print $fun_enter[$taint_track_index]." ";
#        print $tainted_variables[$taint_track_index]."\n";
           $counter++;
      }
#############################################################################################################
     }   	
	close $src_file;	
	


my $File = "./new_output.txt";						
open my $taint_file, '>', $File or die "Cannot not open file"; 
my $amit;

 my $tmp_variable = 0;
 while($tmp_variable < @fun_enter)
 
{

$amit=$tainted_variables[$tmp_variable];
 

$amit=~s/^\s*//;
$amit=~s/\s*$//;

  print $taint_file "$fun_enter[$tmp_variable] ";
  print $taint_file "$tainted_variables[$tmp_variable]\n";
  
  #print $start_of_function[$tmp_variable]."\n"; 
  
  $tmp_variable++;
 
 }
 
 
