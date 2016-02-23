#include<stdio.h>
#include<stdlib.h>
#include<string.h>


char conc(int tpt,char p[])
{
  int r,s,b;
  char f;
  b=10;
  r=tpt+b;
  
  printf(" TPT : %d",r);
  
  if(tpt>=0)
  {
        printf("It is Greater than 0");
  }
  else
  {
       printf("Lesser than 0");
  
  }	

  f=(char)select_result(r,0);
  
  b = call_graph(tpt,10);
 return f;
}

int select_result(int fd, int event)
{
  int pty_utmp_helper_pipe,ret;
  
   if (fd) 
   {
	close();   
	pty_utmp_helper_pipe = -1;
   } 
    else
    {
	char *location = event;
	
	int len = strlen(location)+1, pos = 0;   
	
	while (pos < len) 
	{
	    int ret = write(pty_utmp_helper_pipe, location+pos, len - pos);
	    if (ret < 0)
	     {
		perror(" Changing Path");
		close(pty_utmp_helper_pipe);   
		pty_utmp_helper_pipe = -1;
		ret = malloc(strlen(fd)+1);
		break;
	    }
	    pos += ret;
	}
    }
    return ret;
}
