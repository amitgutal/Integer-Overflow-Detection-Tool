
#!usr/bin/perl;

use strict;
#use warnings;

## ----------------------------------- CODE AFTER CFLOW EXECUTED ---------------------------- ###


sub check_start_end;        # Function which checks for Start { And End } of Function. 


sub check_lineno_function;       # Function which checks for Function Call in the Function Declaration 

sub check_fun_last_end_in_out;

sub out_put;
#----------------------------------CalCulating Level-------------
#     my $prev_level = rindex($line,"\$");
#         $prev_level = rindex($line,"#");
 
#  my $prev_level=0;


my $tmp_file = "pat_temp.txt";				# Output stored into this file.		
open my $f_tmp,'<', $tmp_file or die "Could not open file";       # Page 95 Ebook 

my $out_f = "out.txt";				# Output stored into this file.		
open my $of,'>', $out_f or die "Could not open file";       # Page 95 Ebook 


my @ary = <$f_tmp>;

my (@file_name1,@fun_name1,@line_no1);
my @index_arr;
my $cnt=0;


my (@out_file_name,@out_fun_name,@out_start,@out_end);


my $ary_line_count=0;

my $nxt;
my $var_temp=1;
my $level=0; 

my $ct=0;

my $out_cnt = 0;

while($ary[$cnt])
{
   $ary[$cnt] =~ s/#/\$/;         
 
#   print $ary[$cnt];
     chomp $ary[$cnt];
    
   $index_arr[$cnt] = rindex $ary[$cnt],"\$";         

  my $new_str = substr $ary[$cnt],$index_arr[$cnt]+1;

# print "$index_arr[$cnt]\n";

#print $new_str;

my($fun,$file,$l_no,$recursive) = split  ' +', $new_str;

  $file_name1[$cnt] = $file;
  $fun_name1[$cnt]  = $fun;
  $line_no1[$cnt]   =  $l_no;
  
  
 # print $recursive_info[$cnt];
   
#   print $ary[$cnt];
#   print $index_arr[$cnt]."\n";

   $cnt++; 
}


while(@ary)
{
       
              
            my $cur_level = $index_arr[$ct];  
           
	    my $nxt_level;
	   
	    # print " CURRENT LEVEL ----------------- : $fun_name1[$ct]\n";
	     
	   #  print " NEXT LEVEL ----------------- : $fun_name1[$ct+1]\n";	    
	   
	  
                
		$nxt_level = $index_arr[$var_temp];
		
		my $index_nxt_level = $var_temp;
                
		
	#	print "Next : $nxt_level\n";
      #        	print $file_name[$ct]; 
      
 #  print "Curr : $cur_level\n Next : $nxt_level\n";    
 
 
	    # print " CURRENT LEVEL ----------------- : $fun_name[$ct]\n";
	     
	   #  print " NEXT LEVEL ----------------- : $fun_name[$var_temp]\n";  
	   
	   
############################################################################################################################	   
	   
    if($nxt_level eq "")
	{
	       my $rt_line = &check_start_end($file_name1[$ct],$fun_name1[$ct] ,$line_no1[$ct]);

		 #  print $file_name1[$ct]." ".$fun_name1[$ct]." ".$line_no1[$ct]." ".$rt_line."\n"; 
		     
		       
			    $out_file_name[$out_cnt] = $file_name1[$ct]; 
			    $out_fun_name[$out_cnt] = $fun_name1[$ct];
			    $out_start[$out_cnt] = $line_no1[$ct];
			    $out_end[$out_cnt]= $rt_line;
		            $out_cnt++;
		            $ary_line_count++;
			    
	 
			    #   my $only_tmp = $ct;
	
        #$ print "NEXT LEVEL $nxt_level HEYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY \n";
  
               my $tp_count =0;
	      
	       my $tnt_cmp = $ct;
	       my $temp_nxt = $cur_level;
	      
	       
              while($tnt_cmp >= 0)
	      {
                  if($temp_nxt > $index_arr[$tnt_cmp])
		    {
		       
                          my ($new_start,$fun_1,$org_filename) = &check_fun_last_end_in_out($fun_name1[$tnt_cmp],$ary_line_count);
			    
			    # $new_start = $new_start + 1;
			    
			    my $new_end = &check_start_end($org_filename,$fun_name1[$tnt_cmp] ,$line_no1[$tnt_cmp]);
					  
			    
			    $out_file_name[$out_cnt] = $org_filename; 
			    $out_fun_name[$out_cnt] = $fun_name1[$tnt_cmp];
			    $out_start[$out_cnt] = $new_start;
			    $out_end[$out_cnt]= $new_end;
		     
			    $ary_line_count++;
			    $out_cnt++;	
			
		
                         $temp_nxt = $index_arr[$tnt_cmp];         
                        
                         #$ print " Function : $fun_name1[$tnt_cmp]\n\n";
                    }
		    
		    
		   
		    
		    $tnt_cmp--;  
             }
	         
  #                $tnt_cmp = $index_arr[$ct];
		  
		  
               while($tp_count != $out_cnt)
                 {
           
                   print $of $out_file_name[$tp_count]." ";
 	           print $of $out_fun_name[$tp_count]." ";
 	           print $of $out_start[$tp_count]." ";
                   print $of $out_end[$tp_count]."\n";
	 
	           $tp_count++;
		   
		   #print "------- TNT CMP : $tnt_cmp \n";
                 }
         
	        #$  print "NEXT LEVEL $nxt_level HEYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY \n";
	#print "----------------------------\n";
	
		exit(1);
	     
       }
       
       
######################################################################################################################################     
		
		if($cur_level < $nxt_level)
		{     
		           my $ny = $ct+1;
			   
			   
		       
			  # print "Cur_level : $cur_level\n";
			   
			   #print "Next_level : $nxt_level\n";
			   
			   my $rt_line = &check_lineno_function($file_name1[$ct],$fun_name1[$ct],$fun_name1[$ny] ,$line_no1[$ct]);
                          
			    #print $file_name1[$ct]." ".$fun_name1[$ny]." ".$line_no1[$ct]." ".$rt_line."\n"; 
			 
			    
			    $out_file_name[$out_cnt] = $file_name1[$ct]; 
			    $out_fun_name[$out_cnt] = $fun_name1[$ct];
			    $out_start[$out_cnt] = $line_no1[$ct];
			    $out_end[$out_cnt]= $rt_line;
		            $out_cnt++;
                            $ary_line_count++;
			    
	       } 
		  
######################################################################################################################################          

       if($cur_level == $nxt_level)
       {
       
                 
			  
                 my $rt_line = &check_start_end($file_name1[$ct],$fun_name1[$ct] ,$line_no1[$ct]);

		 #  print $file_name1[$ct]." ".$fun_name1[$ct]." ".$line_no1[$ct]." ".$rt_line."\n"; 
		     
		       
			    $out_file_name[$out_cnt] = $file_name1[$ct]; 
			    $out_fun_name[$out_cnt] = $fun_name1[$ct];
			    $out_start[$out_cnt] = $line_no1[$ct];
			    $out_end[$out_cnt]= $rt_line;
		            $out_cnt++;
		            $ary_line_count++;
			    
	 
			     my $only_tmp = $ct;
			     
			    #@ print "Before Tmp : $fun_name1[$only_tmp]\n";
			    
			     my $crt_ind = $only_tmp+1;
			     my $flag =0;
			     
			     while($flag eq 0)
			     {
			     
		              #@ print "Current level : $cur_level\n";
			      #@ print "Only tmp  : $only_tmp\n";
		              #@ print "Index Arr : $index_arr[$only_tmp]\n";
			      #@ print "Only tmp  : $only_tmp\n";
			      #@ print "========================\n";
			     
			           if($cur_level > $index_arr[$only_tmp])
			           {
			               # print "Curr : $fun_name1[$only_tmp]\n";
				       
			               
				       my ($new_start,$fun_1,$org_filename) = &check_fun_last_end_in_out($fun_name1[$only_tmp],$ary_line_count);
				       
				       #@ print "New Start : $new_start\n";
				       
				       my $ttmp = $only_tmp;
				       
				      # print "--------->>> : $fun_name1[$crt_ind]\n";
				       
				       # $new_start = $new_start + 1;
				       
			               my $new_end = &check_lineno_function($org_filename,$fun_name1[$ct],$fun_name1[$crt_ind] ,$new_start);     
				       
				       # print "New End : $new_end\n";
				      
				       
			                    $out_file_name[$out_cnt] = $org_filename; 
			                    $out_fun_name[$out_cnt] = $fun_name1[$only_tmp];
			                    $out_start[$out_cnt] = $new_start;
			                    $out_end[$out_cnt]= $new_end;
		     
			                    $ary_line_count++;
			               
				            $out_cnt++;
					    
				   	    
					      
					      
				       $flag =1; 
				       
				       
				       
			           }
			        $only_tmp--;
			
			       # while(() or ($curr_level eq $index_arr[$only_tmp]))
			       #    {
			       #         if($index_arr[$only_tmp] lt $curr_level)
			       #         {
	              	       #               print "Current : $fun_name1[$only_tmp]\n";
			       #		      $flag = 1;
					   
				#	}
				#	$only_tmp--; 
		                #   } 
			      
	                     } 
			     

       }
 ######################################################################################################################################          
 

		if($cur_level > $nxt_level)
		{
   	             
		       
		       
			   my $rt_line = &check_start_end($file_name1[$ct],$fun_name1[$ct] ,$line_no1[$ct]);

		        #   print $file_name1[$ct]." ".$fun_name1[$ct]." ".$line_no1[$ct]." ".$rt_line."\n"; 
		     
		       
			    $out_file_name[$out_cnt] = $file_name1[$ct]; 
			    $out_fun_name[$out_cnt] = $fun_name1[$ct];
			    $out_start[$out_cnt] = $line_no1[$ct];
			    $out_end[$out_cnt]= $rt_line;
		            $out_cnt++;
		            $ary_line_count++;
			    
		    
			     
		     
		        my $tmp_cnt = $ct; 
	 	# New	
		#	print $tmp_cnt;
			
         	        $tmp_cnt = $tmp_cnt-1;
			
		        my $flag =0;
			
                        my $temp_cur_level = $cur_level;
			
			while($flag == 0 and ($tmp_cnt >= 0))
		       {
		          	
				
 			#	---------- Case 1  
			
			
			if($temp_cur_level > $index_arr[$tmp_cnt])
			{
			   
			          
			    #  print " Amit New Tmp : $fun_name1[$tmp_cnt]\n";
			    
			    my ($new_start,$fun_1,$org_filename) = &check_fun_last_end_in_out($fun_name1[$tmp_cnt],$ary_line_count);
			    
			   # print "New Start : $new_start\n";
			   # $new_start = $new_start + 1;
			    my $new_end = &check_start_end($org_filename,$fun_name1[$tmp_cnt] ,$line_no1[$tmp_cnt]);
			    
			  #  print "New End $new_end $org_filename $fun_name1[$tmp_cnt] $line_no1[$tmp_cnt]\n\n";
			    
			    $out_file_name[$out_cnt] = $org_filename; 
			    $out_fun_name[$out_cnt] = $fun_name1[$tmp_cnt];
			    $out_start[$out_cnt] = $new_start;
			    $out_end[$out_cnt]= $new_end;
		     
			    $ary_line_count++;
			    $out_cnt++;	
			  
			 $temp_cur_level = $index_arr[$tmp_cnt];  
				   # print "Index :$ary[$tmp_cnt] \n";
				# print $ary[$tmp_cnt]."\n";
			}
			        #my @ary_tmp = <$of_tmp>;
			        # print "Ary :$index_ary[$f_cnt]";
			        # print "\n Arry : $ary_tmp[0]\n";
			        #   close $of_tmp;			
				##  print "Line: $f_cnt\n";
		  	      
 		       if($nxt_level == $index_arr[$tmp_cnt])
		       {	
			   
			   my $new_flag = 0;
			   my $cnt_tmp = $tmp_cnt;
			    
			   while($new_flag eq 0 and ($cnt_tmp >= 0))
			   {
			   			   
			        if($nxt_level > $index_arr[$cnt_tmp])
				{
				 #$    print "Function Found : $fun_name1[$cnt_tmp]\n\n";  
				    
				    my ($new_start,$fun_1,$org_filename) = &check_fun_last_end_in_out($fun_name1[$cnt_tmp],$ary_line_count);
				     
				    my $new_end = &check_lineno_function($org_filename,$fun_name1[$ct],$fun_name1[$index_nxt_level] ,$new_start);      
				    
				    
				 #$    print "\n Next Function Found : $fun_name1[$index_nxt_level]\n"; 
				    
				 #   $new_start = $new_start + 1;
				    
			      $out_file_name[$out_cnt] = $org_filename; 
			      $out_fun_name[$out_cnt] = $fun_1;
			      $out_start[$out_cnt] = $new_start;
			      $out_end[$out_cnt]= $new_end;
		     
			      $ary_line_count++;
			      $out_cnt++;	
			   	    
			 
			       $new_flag = 1;
			 }
			          $cnt_tmp--;
			   
			   }
			   
			   
			   

							

			#	print $ary[$ct-1]."\n";
		              $flag =1;
				
		       }
		     $tmp_cnt--;
		   }
    		
	 } 
###########################################################################################################################################				 
 
$var_temp++;          
                
$ct++;
  
 
}

 
#  print "Next : $nxt_index\n";
  
 #  print "Level : $level\n";
#     print  "Fisrt :$line";
#     print "Second :$line_tmp";




#    print $level."\n"; 
    
#   if($ind1 != -1)
#   {
#      my $tmp_level=rindex($var,$ind1);   

#    if($tmp_level > $level) check_fun_last_end_in_out
#       {
#          $level++;
#       } 
#    if($tmp_level < $level) 
#       {
#          $level--;
#       } 
#  
#   }
sub out_put()
{

my $put = @_;
my $tp_count = 0;

#print $put."Hello\n";
while($tp_count < $put)
{

#$       print $out_file_name[$tp_count]." ";
#$ 	  print $out_fun_name[$tp_count]." ";
#$ 	  print $out_start[$tp_count]." ";
#$           print $out_end[$tp_count]."\n";
	  $tp_count++;
}


}


sub check_fun_last_end_in_out()
{

    my ($function_name,$line_number) = @_;

    my $line_no = $line_number;
#$ print "---------------------------OUTPUT------------------------------------\n";
    
#   print $function_name."\n";
   
   
   my $doub_flag =1;
   
   
#$ print "---------------------------END ------------------------------------\n";
 
    while($line_no != -1)
    {
       if($function_name eq $out_fun_name[$line_no])
       {
           
	 # print $out_end[$line_no]."\n";
         # print "$out_fun_name[$line_no]\n";
	 
	 if($out_end[$line_no] == $out_start[$line_no])
	 {
	     return $out_end[$line_no],$out_fun_name[$line_no],$out_file_name[$line_no];
	 }
	 else
	 { 
	    my $var_tmp= $out_end[$line_no] +1;
	    return $var_tmp,$out_fun_name[$line_no],$out_file_name[$line_no];
	  }
       }  
       $line_no--;
    }
     

#------------------------Final OutPut File ------------#

}

     
#if($ind2 != -1)
#   {
#       my $tmp_level=rindex($var,$ind2);   
      
#    if($tmp_level > $level) 
#       {
#          $level++;
#       } 
#    if($tmp_level < $level) 
#       {
 #         $level--;
#       } 
  
#   }

# }
     
##-------------------------------------------------------------------------------------------  

 #  check_start_end("test.c","main",127);        # CALL 
  # print "Hello ".check_lineno_function("test.c","errf",127);

#------------------- CHECK FOR Line No. of FUNCTION CALL in Function Defination   --- START "{"   END  "} "  

sub check_lineno_function() 
{

    my ($file_name,$org_funname,$search_function_name,$line_number) = @_;
    
   # print "Check $file_name $function_name $line_no\n";
   
   my $line_no = $line_number;
     
    open my $fo, '<', $file_name or die "Could not open file";       				# Page 95 Ebook 
    
    my $new_flag = 0;
	 
    my $line_count =1;
    
   my $stat_flag = 1;
	 while($line_count != $line_no and my $line = <$fo>)
	 {
	     $line_count++;                    # Takes the file pointer to a particular Line 
	 }
	  
        if($org_funname eq $search_function_name)
	{
	  
           while(($stat_flag==1) and my $line = <$fo>)
	   {
                $line_count++;
		$stat_flag =0;
	   }
	
	
	}
	#print $search_function_name."\n";
          while(my $line = <$fo>)
	  { 
	     if($line =~/$search_function_name/)
	     {
   	          return $line_no;
#	          print "Line Count $line_no \n Line : $line\n ";
             }
	     
	     else
	     { 
	  #   print "Line Count $line_no \n Line : $line\n ";
	       $line_no++;

	     }
	  }
	  return $line_number;
	  

}


 #------------------- CHECK FOR FUNCTION DEFINATION --- START "{"   END  "} " 

 
sub check_start_end()
{
         my ($file_name,$function_name,$line_no) = @_;
	 
	 # print "$file_name $function_name $line_no";
	
 	 my $flag=0;	
	 
	#  print $file_name."\n";
	 # print $function_name."\n";
	  
	 # print "------------------------\n";											# Output stored into this file.		
         open my $fo, '<', $file_name or die "Could not open file";       				# Page 95 Ebook 
	 
	 my $line_count =0;
	 
	 while($line_count != $line_no and my $line = <$fo>)
	 {
	     $line_count++;                    # Takes the file pointer to a particular Line 
	 }
	 
        
	# Following two if-else ladder determines, which statment belongs to which function.  
	
	my $brace_cnt=0;
	my $check_flag = 0;
	
	while(my $line = <$fo>)
	{
	#print $line;
			   if($line =~ /{/)
				   {
		 			 $brace_cnt++;
					 $check_flag =1;
					 
	   		           }
          
        	    if($brace_cnt != 0)
	            {
	                $line_no++;
	            }
	    

	              if($line =~ /}/)
           	    {  
              	                	$brace_cnt--;
                    }  
	  

            #print "Line : $line\n";
            #print "Line No. : $line_no\n";
	    
	    if($brace_cnt == 0 and ($check_flag == 1))
	    {
	        return $line_no;
                exit(0);	          
	    }


	} 
 
}


