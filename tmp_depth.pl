#use warnings;

my $filename1 = "pat_tmp.txt";						
open my $f2,'<',$filename1 or die "Could not open file";       # Page 95 



my @depth;
my @fun_name;
my @index;
my $cnt = 0;
while(my $line = <$f2>)
{
   $line=~s/#/\$/;
   $index[$cnt] = rindex $line,"\$";
   
   my $new_str = substr $line,$index[$cnt]+1;
  
     
  ($fun_name[$cnt],$file_name,$line_no)=split ' ',$new_str;
   
   print $index[$cnt]."\n";
   print $fun_name[$cnt]."\n";
   $cnt++;
}  

$dep = 0;
my $tmp_var =0;
while($tmp_var < @index)
{
  if($index[$tmp_var] < $index[$tmp_var+1])
  {
       $depth[$tmp_var] = $dep;
       $dep++;
       print $depth[$tmp_var];
  }

  $tmp_var++;
}








 

     
