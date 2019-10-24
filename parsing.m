#include "fdf.h"

void	ft_init_data(t_data *data)
{
	data->bpp = 24;
    data->size_line = 5000 * 3;
    data->endian = 0;
    data->color = 0;
    data->wc = 0;
    data->posx = 0;
	data->posy = 0;
	data->vol = 1;
	data->zoom = 1;
	data->step = 1;
	data->rep = 1;
	data->mlx_ptr = 0;
	data->img_ptr = 0;
	data->addr = 0;
}

int		ft_trace_fdf(t_data *data, char **map)
{
	int i;
	char	**buff_start;
	char	**buff_end;

	i = 0;
	data->img_ptr = mlx_new_image(data->mlx_ptr, 5000, 5000);
    data->addr = mlx_get_data_addr(data->img_ptr, &(data->bpp),
        &(data->size_line), &(data->endian));
	while (map[i])
    {
        data->wc = ft_word_count(map[i]);
        if (!(buff_start = ft_split(map[i])))
			return (0);
        ft_trace_sstr(buff_start, data, i * 10);
        if (i > 0)
            ft_trace_vert(buff_end, buff_start, data, (i - 1) * 10);
        if (!(buff_end = ft_split(map[i])))
			return (0);
        i++;
    }
	free(buff_start);
	free(buff_end);
	return (0);
}

char	**ft_get_map(int ac, char **av)
{
	int     fd;
	int		i;
	char    **map;

	i = 0;
	fd = 0;

	if (!((map = (char**)malloc(sizeof(char*) * (ft_line_count(av[1], fd) + 1)))) || ac != 2)
		return (0);
	fd = open(av[1], O_RDONLY);
	while (get_next_line(fd, &(map[i])) == 1)
		i++;
	map[i] = 0;
	return (map);
}

int		ft_line_count(char *file, int fd)
{
	int		lc;
	int		i;
	int		x;
	char	*buff;

	i = 0;
	lc = 0;
	x = 0;
	if (!(buff = malloc(BUFF_SIZE + 1)))
		return (0);
	fd = open(file, O_RDONLY);
	while ((x = read(fd, buff, BUFF_SIZE)) > 0)
	{
		buff[x] = '\0';
		while (buff[i] != '\0')
		{
			if (buff[i] == '\n' || buff[i] == EOF)
				lc++;
			i++;
		}
		i = 0;
	}
	free(buff);
	close(fd);
	return (lc + 1);

}

void	ft_check_map(char **map)
{
	size_t	len;
	int		i;
	int		j;

	i = 0;
	len = 0;
	j = ft_word_count(map[i]);
	while (map[i] != 0)
	{
		if (ft_word_count(map[i]) != j)
		{
			
			ft_putstr("Error : Found wrong line length. Exiting.\n");
			exit (1);
		}
		i++;
	}
}

char	*ft_strncpy(char *dst, const char *src, size_t len)
{
	size_t i;

	i = 0;
	while (i < len && src[i] != '\0')
	{
		dst[i] = src[i];
		i++;
	}
	if (i != len && src[i] == '\0')
	{
		while (i < len)
		{
			dst[i] = '\0';
			i++;
		}
	}
	return (dst);
}

long long int	ft_pow(int base, int x)
{
	if (x != 0)
		return (base * ft_pow(base, x - 1));
	else
		return (1);
}

int	ft_word_count(char *str)
{
	int i;
	int x;
	int j;

	j = 0;
	i = 0;
	x = 0;
	while (str[j] != 0 && str[j] != '\n')
		j++;
	while (i < j)
	{
		while ((str[i] && str[i] == ' ') || str[i] == '\t')
			i++;
		if (str[i] != ' ' && str[i] != '\t' && str[i] != '\n' && str[i] != 0)
		{
			while (str[i] && str[i] != ' ' && str[i] != '\t')
				i++;
			x++;
		}
	}
	return (x);
}

char *ft_cpy_str(char *str, int rang)
{
	int x;
	int i;
	char *cpy;

	x = 1;
	i = 0;
	while (x < rang)
	{
		while (str[i] && str[i] != ' ')
			i++;
		while (str[i] && str[i] == ' ' && str[i] != '\n')
			i++;
		x++;
	}
	x = i;
	if (str[i] == '-')
		i++;
	while (str[i] != ' ' && str[i] != '\t' && str[i] != '\n' && str[i] != 0)
		i++;
	if (!(cpy = ft_strnew(i - x)))
		return (0);
	cpy = ft_strncpy(cpy, &(str[x]), i - x);
	return(cpy);
}

char **ft_split(char *str)
{
	int x;
	int i;
	char **sstr;

	x = ft_word_count(str);
	i = 1;
	if (!(sstr = (char**)malloc(sizeof(char*) * (x + 1))))
		return (0);
	while (i < x + 1)
	{
		if (!(sstr[i] = ft_cpy_str(str, i)))
			return (0);
		i++;
	}
	return (sstr);
}

int				ft_get_nbr(char *str)
{
	int i;
	int x;
	int s;

	i = 0;
	x = 0;
	s = 1;
	if (!(str))
		return (0);
	if (str[i] == '-')
	{
		s = -1;
		i++;
	}
	while (str[i] >= '0' && str[i] <= '9' && str[i] != '\0')
	{
		x = (x * 10) + (str[i] - 48);
		i++;
	}
	return (x * s);
}