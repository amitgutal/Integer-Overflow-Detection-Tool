#use warnings;

sub check_with_patterns;


################################## CALCULATE DEPTH #################################################

my $filename_1 = "pat_temp.txt";						
open my $fread2,'<',$filename_1 or die "Could not open file";       # Page 95 
 
my $MaxDepth =0;

my @depth;
my @fun_name;
my @depth_fun;
my @index;
my $cnt = 0;
my $flag =0;
my $DepthIndex=0;
while(my $line = <$fread2>)
{
   $line=~s/#/\$/;
   $index[$cnt] = rindex $line,"\$";
   
   my $new_str = substr $line,$index[$cnt]+1;
  
     
  ($fun_name[$cnt],$file_name,$line_no)=split ' ',$new_str;
   
#   print $index[$cnt]."\n";
#   print $fun_name[$cnt]."\n";
   $cnt++;
}  

$dep = 0;
 
my $fname1 = "a1.txt";						
open my $f_ptr,'<',$fname1 or die "Could not open file";       
$flag=0;

open my $out_depth,'>',"depth.txt" or die "Could not open file";   
$flag=0;

my $inner_var =0;

  while(my $read = <$f_ptr>)
  {
    my $tmp_var =$inner_var;
#    print $read;
      $flag=0; 
      while($tmp_var < @index and $flag ==0)
       {
         #print $var."\n";
	 $var = $fun_name[$tmp_var];
          if($read =~/\s+$var/)
          {
  
          
          
#	   my $top = rindex $read,"}";

           my $dth = substr($read,2,3); 
	   
	    $depth_fun[$dep] = $var;
	    $depth[$dep] = $dth;
	    print $out_depth "$var $dth\n";
	    
	    if($MaxDepth < $dth)
	    {
	         $MaxDepth = $dth;
	    }
	   # print "$depth_fun[$dep]\n";
	    #print "$depth[$dep]\n";
	    $dep++;
 
	  

	   $flag=1;
          }
       $tmp_var++;
     }

  }

############################################## END OF DEPTH CALCULATION #############################################
$cnt =0;




################################### START OF MAIN PROGRAM ###########################################################
my $filename1 = "new_output.txt";						
open my $f2,'<',$filename1 or die "Could not open file";       # Page 95 


my $rread = "out.txt";						
open my $f_read,'<',$rread or die "Could not open file";       # Page 95 


$~ = "OUTPUT_FORMAT";
write;



my $tmp_counter=0;
my @fun_names;
my @tainted_names;

my $tmp_variable="";

my @tainted_variables;

while(my $line_func_read = <$f2>)
{
#        print $line_func_read;
	my ($function_name ,$tainted_names) = split " ",$line_func_read;
        $fun_names[$tmp_counter] = $function_name;
	$tainted_names[$tmp_counter] = $tainted_names;
	
#	print $function_name;
   #     print $fun_names[$tmp_counter]." ".$tainted_names[$tmp_counter]."\n";
	
 $tmp_counter++;
         
}


################## READING SOURCE FILE : 

while(my $read_out = <$f_read>)
{
     my ($file_name,$fun_name,$start,$end) = split " ",$read_out;
      
      my $ary_ind=0;
      my $fun_flag =1;
        while($ary_ind < @fun_names and $fun_flag ==1)
	{
	        if($fun_names[$ary_ind] eq $fun_name)
		{
		   #  print "Found----------- $fun_name \n\n\n";
		   #  print "$tainted_names[$ary_ind]\n\n";
		     
		     @tainted_variables = split ",",$tainted_names[$ary_ind];
		     $fun_flag =0;
		     
		     
		    
		}
          $ary_ind++;		
	}
    
#print $st;
    open my $src_file,'<',$file_name or die "Could not open file";       # Page 95 
    
    
    my $cnt = 1;
    
    while($cnt < $start and my $file_read = <$src_file>)
	   {
	           $cnt++;
#                  print $line;
	   }
	   
#	 print "------------ Enter Function : $fun_name ----- --------------\n\n" ;    
   while($cnt <= $end and my $file_read = <$src_file>)
     {
       #print "main :::::::::::::::::::::::::::::::::::::::::$file_read\n"; 
       foreach $var(@tainted_variables)
	{
        
	#  print "Variable :".$var."\n\n";
	if($tmp_variable eq $var)
	{
	}
	else
	{         #  print "Line for Pattern Matching : $file_read\n\n";     
	  
	          if($file_read =~/([\(\)_,;\t \n\+\-\*\/\[\]]+)($var)([\(\)_,;\t \n\+\-\*\/\[\]]+)/)
                  {
		  
		#           print "Matched : $file_read\n\n";
			   my $temp_line = $file_read;
			   #chomp $temp_line;
			   
	#		   print $temp_line;
                           $temp_line =~s/$2/tainted_variable/gx;
#			   print $+;

			#    print "Replace : $temp_line\n\n";
     		            &check_with_patterns($file_name,$fun_name,$cnt,$var,$temp_line,$file_read);  

                  }   
        }         
           $tmp_variable = $var;
        
	}
     $cnt++; 
     }
    
}

############# END OF READING OF SOURCE FILE 
sub check_with_patterns() 
{
       local($fil_name,$function_name,$line_number,$taint_var,$taint_line,$read_file) = @_;
       
    #   print "taint Line : $taint_line\n"; 
    #   print $line_no."\n";
    #   print $file_name."\n";
       
my $st="config.txt";
#print $st;
open my $f1,'<',$st or die "Could not open file";       # Page 95     

my $str = "/";


local($dep)=0;

while(my $read = <$f1>)
{
  
  #print "-----------\n";
  #print "Line :$read_file\n";
  #print "Original PAttern : $read\n";
  #print "Tainted : $taint_line\n"; 
  #print "----------\n";
  
#chomp $read;
#chomp $taint_line;

   if($taint_line=~/$read/gx)
   {
        my $d_flag =0;
        while($DepthIndex < @depth_fun and $d_flag==0)              ### Note  : Depth Index is a Global Variable
	{
	    if($depth_fun[$DepthIndex] eq $function_name)
	    {
	        
		$dep = $depth[$DepthIndex];
	        $d_flag = 1;
	    }
	 $DepthIndex++;    
		
	}
	$DepthIndex--;
	$d_flag =0;
	

	
	$~ = "FORMAT";
        write;
	



format FORMAT = 
@<<<<<<<<<<<<<<<<<< @<<<<<<<<<<<<<<<<<<<<<<    @<<<<      @<<<@@<<        @<<<<<<<<<   @<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
$fil_name,      $function_name,    $line_number,  $dep, $str,$MaxDepth,   $taint_var,   $read_file
.

     }
} 



}




format OUTPUT_FORMAT = 
=============================================================================================================
	
                                 INTEGER OVERFLOW EXPLOITABILTY TOOL 

=============================================================================================================
File Name           Function Name           Line Number     Depth     Tainted Variable           LINE      

.







 

     
