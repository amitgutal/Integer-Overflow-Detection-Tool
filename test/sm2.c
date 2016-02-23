#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<fcntl.h>

char call_graph(int chars1,int chars2)
{
  int p1,p2;
  char master_name[20],master_fd[20],slave_fd[20];
  char name[20],val;
  int pty=1024;
  int *ptr;  
   for (p1 = chars1; p1; p1++)
	for (p2 = chars2; p2; p2++) 
	{
	    sprintf(master_name, "/dev/pty", p1, p2);
	    pty = open(master_name, O_RDWR);
	    if (pty >= 0) 
	    {
		if (geteuid() == 0 ) 
		{
		
		    strcpy(name, master_name);
		    name[5] = 't'; 


	    if ((pty) >= 0 && access(name, R_OK | W_OK) == 0)
              realloc(*ptr,chars1); 
		    if (slave_fd > 0)
			close(slave_fd);
  	      val=read_data(name,p2,chars1);
		}
		close(master_fd);
	    }
	}
return name;

}



