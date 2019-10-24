#include "fdf.h"

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

	i = 0;
	x = 0;
	while (i < ft_strlen(str))
	{
		while (str[i] && str[i] == ' ')
			i++;
		while (str[i] && str[i] != ' ')
			i++;
		x++;
	}
	return (x);
}

char *ft_cpy_str(char *str, int rang)
{
	int x;
	int i;
	int j;
	char *cpy;

	j = 0;
	x = 0;
	i = 0;
	while (x < rang)
	{
		while (str[i] && str[i] != ' ')
			i++;
		while (str[i] && str[i] == ' ')
			i++;
		x++;
	}
	if (x == rang)
	{
		x = i;
		while (str[i] && str[i] != ' ')
			i++;
		cpy = ft_strnew(i - x);
		i = x;
		while (str[x] && str[x] != ' ')
		{
			cpy[j] = str[x];
			x++;
			j++;
		}
		return(cpy);
	}
	return (NULL);
}

char **ft_split(char *str)
{
	int x;
	int i;
	char **sstr;

	x = ft_word_count(str);
	i = 0;
	sstr = (char**)malloc(sizeof(char*) * x + 1);
	while (i < x)
	{
		sstr[i] = ft_cpy_str(str, i);
		printf("i, %d\nsstr %s\n", i, sstr[i]);
		i++;
	}
	printf("fin \n");
	return(sstr);
}

int				ft_get_nbr(char *str)
{
	int i;
	int x;
	int s;

	i = 0;
	x = 0;
	s = 1;
	if (!(str[i]))
		return (0);
	if (str[i] == '-')
	{
		s = -1;
		i++;
	}
	while (str[i] && str[i] != '\0')
		{
			x = (x * 10) + (str[i] - 48);
			i++;
		}
	return (x * s);
}

int		ft_trace_vert(char **sstr_start, char **sstr_end, t_data *data, int y, int wc)
{
	int i;
	int x;
	int z;
	int temp;
	t_coord a;
	t_coord b;

	x = 0;
	i = 0;
	z = 0;
	while (x < wc - 1)
	{
		printf("rang X = %d\n", x);
		z = ft_get_nbr(sstr_start[x]);
		a.x = (i - y) + 200;
		a.y = ((i + y) - z) + 200;
		temp = z;
		z = ft_get_nbr(sstr_end[x]);
		b.x = (i - y - 10)  + 200;
		b.y = ((i + y + 10) - z)+ 200;
		z = (z > temp ? z : temp);
		ft_put_line_img(a, b, data, z);
		x++;
		z = 0;
		i += 10;
	}
	return (1);
}


int		ft_trace_sstr(char **sstr, t_data *data, int y, int wc)
{
	int x;
	int i;
	int z;
	int temp;
	t_coord a;
	t_coord b;

	x = 0;
	i = 0;
	z = 0;
	while (x + 1 < wc)
	{
		if (x + 1 < wc)
			z = ft_get_nbr(sstr[x]);
		a.x = (i - y) + 200;
		a.y = ((i + y) - z)  + 200;
		temp = z;
		if (x < (wc - 2) && sstr[x + 1])
			z = ft_get_nbr(sstr[x + 1]);
		b.x = (i + 10 - y)  + 200;
		b.y = ((i + 10 + y) - z) + 200;
		printf("explique fdp :\n rang : x %d \na.x : %f\n a.y : %f\n b.x, %f\n, b.y %f\n, SSTR X %s\n", x, a.x, a.y, b.x, b.y, sstr[x]);
		z = (z > temp ? z : temp);
		ft_put_line_img(a, b, data, z);
		x++;
		z = 0;
		i += 10;
	}
	return (1);
}

/* int		ft_link_sstr(char **sstr_first, char **sstr_second, char *data, int y)
{
	int x;
	t_coord a, b;

	x = 0;
	while (sstr_first[x])
	{
		z = ft_get_nbr(sstr_second[x]);         // WTF
		a.x = ??;
		a.y = ??;
		xa = lround((x - y) * cos(60));
		ya = lround((-(x + y) * sin(60))) + z;
		b.x = xa;
		a.y = ya;
		ft_put_line_img(a, b, data);
	}
} */

void	ft_coord_swap(t_coord *a, t_coord *b)
{
		a->x += b->x;
		b->x = a->x - b->x;
		a->x -= b->x;
		a->y += b->y;
		b->y = a->y - b->y;
		a->y -= b->y;
}

int     ft_put_pixel_img(t_data *data, int x, int y, int z)
{
    int b;
    int i;
	char *cpy;
	int color = data->color;
	if (z > 5)
		color = 255000;
	else
		color = 255000000;
	cpy = data->addr;
    b = data->bpp / 8;
    i = 0;
    data->addr += y * data->size_line;
    data->addr += x * b;
    while (i <= 2)
    {
    	*((data->addr) + i) = color / ft_pow(10, 3 * (b - 1));
        color =  color - (color / ft_pow(10, 3 * (b - 1)) * ft_pow(10, 3 * (b - 1)));
        b--;
        i++;
    }
	data->addr = cpy;
    return (1);
}

void ft_put_line_img(t_coord a, t_coord b, t_data *data, int z)
{
	double	coeff;
	double	x;
	int		y;
	int		res;

	y = a.y;
	x = 0;
	if (b.x < a.x)
		ft_coord_swap(&a, &b);
	if (b.x != a.x)
		coeff = (b.y - a.y) / (b.x - a.x);
	else
		coeff = 0;
	while (a.x + x < b.x)
	{
		y = ceil(x * coeff) + a.y;
		res = ft_put_pixel_img(data, a.x + x, y, z);
		x += 1;
	}
}