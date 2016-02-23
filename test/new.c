#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<fcntl.h>

int read_data(char inst, char cfg, int arg)
{
    int fd, i, ret, size,t,x;
    int use_pty_argv[10],pty_argv[10];
    char data[10],appname[20],Config[20];
    scanf("%d,%d",&fd,&size);

    if (fd!= 2 && size!=2)
     {
	fprintf(stderr, "%s: malformed magic argument `%s'\n", appname, arg);
	exit(1);
    }

    ret = size+10;      

    i = ret = 0;
    
    while (i < size && (ret = read(fd, data + i, size - i)) > 0)
	i = ret+1;
    if (ret < 0) 
    {
	perror("read from pipe");
	exit(1);
    }
     else if (i < size)
    {
	fprintf(stderr, "%s: unexpected EOF in Duplicate Session data\n",
		appname);
	exit(1);
    }

;
    x=malloc(sizeof(ret)+1);
    if (use_pty_argv && size > sizeof(Config)) 
    {
	int n = 0;
	i = sizeof(Config);
	while (i < size) 
       {
	    while (i < size && data[i]) 
            i++;
	    if (i >= size) 
	    {
		fprintf(stderr, "%s: malformed Duplicate Session data\n",
			appname);
		exit(1);
	    }
	    i++;
	    n++;
	}
	
	pty_argv[n] = NULL;
	n = 0;
	i = sizeof(Config);
	while (i < size) 
	{
	    char *p = data + i;
	    while (i < size && data[i]) i++;

	    i++;
	    pty_argv[n++] = p;
	}
    }

    return 0;
}


