#use warnings;

my $filename1 = "pat_temp.txt";						
open my $f2,'<',$filename1 or die "Could not open file";       # Page 95 
 
my @depth;
my @fun_name;
my @depth_fun;
my @index;
my $cnt = 0;
while(my $line = <$f2>)
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
  
           print $var."\n";
           print $read."\n";
#	   my $top = rindex $read,"}";

           my $dth = substr($read,2,3); 
	   
	    $depth_fun[$dep] = $var;
	    $depth[$dep] = $dth;
	    print $out_depth "$var $dth\n";
	    $dep++;
 
	   print $depth."\n";

	   $flag=1;
          }
       $tmp_var++;
     }

}







 

     
