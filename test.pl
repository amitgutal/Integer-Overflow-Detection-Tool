
my $rread = "out.txt";						
open my $f_read,'<',$rread or die "Could not open file";       # Page 95 

$flag = 0;
while(my $read_out = <$f_read>)
{
 
  my ($file_name,$fun_name,$start,$end) = split " ",$read_out;

 
# print $read_out;
  open my $src_file,'<',$file_name or die "Could not open file";       # Page 95 
    
  my $cnt=1;
      
   #$in=~/\s*malloc\(\s*tainted_variable\s*\+\s*([.A-Za-z0-9_]*(\->)*[.A-Za-z0-9_]*)\s*\)/)
    
     
   while($cnt < $start and my $file_read = <$src_file>)
	   {
	           $cnt++;
#                  print $line;
                   
	   }

  print "------------ Enter Function : $fun_name ----- $cnt    --------------" ;    
		
   while($cnt < $end and my $file_read = <$src_file>)
     {
        $flag=1;
     
     if($file_read=~/\([,A-Ba-z0-9\w]*[\n]+/)
     
      #if($file_read=~/(\w\n)*[A-Za-z0-9]*\([A-Za-z0-9]*(\w\n)+\)*/)
        {
     #                 print $file_read;                  
 #     
        } 
	
	$cnt++;
     }
     
 print "----- $cnt ---\n\n";
}    
      

