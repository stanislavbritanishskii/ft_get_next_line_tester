# include <fcntl.h>
# include <stdlib.h>
# include <unistd.h>
# include <stdio.h>

int main(int argc, char *argv[])
{
	int fd0;
	size_t	size;
	char *str;
	int	parenthesis_counter;

	if (argc != 2)
		return (1);
	
	str = malloc (sizeof(char));
	parenthesis_counter = 0;
	fd0 = open(argv[1], O_RDONLY);
	
	while (parenthesis_counter == 0)
	{
		read(fd0, str, 1);
		if (*str == '{')
			parenthesis_counter++;
	}
	while (parenthesis_counter != 0)
	{
		read(fd0, str, 1);
		if (*str == '{')
			parenthesis_counter++;
		if (*str == '}')
			parenthesis_counter--;
	}

	while (read(fd0, str, 1))
	{
		if (*str == '{')
		{
			close(fd0);
			return (2);
		}
	}
	close (fd0);
	return (0);
}
