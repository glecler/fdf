#include "fdf.h"

float	ft_coordx(t_data data, int x, int y, int z)
{
	if (data.rep == 1)
		return(((10 * x) - y));
	else
		return(10 * x - cos(45) * z * data.vol);
	return (0);
}

float	ft_coordy(t_data data, int x, int y, int z)
{
	if (data.rep == 1)
		return(((10 * x) + y - z * data.vol));
	else
		return(y + sin(45) * z * data.vol);
	return (0);
}


int		ft_trace_sstr(char **sstr, t_data *data, int y)
{
	int x;
	int z;
	t_coord a;
	t_coord b;

	x = 1;
	z = 0;
	while (x < data->wc)
	{
		if (sstr[x])
			z = ft_get_nbr(sstr[x]);
		a.x = ft_coordx(*data, x, y, z);
		a.y = ft_coordy(*data, x, y, z);
		if (x < (data->wc) && sstr[x + 1])
			z = ft_get_nbr(sstr[x + 1]);
		b.x = ft_coordx(*data, x + 1, y, z);
		b.y = ft_coordy(*data, x + 1, y, z);
		if (sstr[x])
			z = (z > ft_get_nbr(sstr[x]) ? z : ft_get_nbr(sstr[x]));
		ft_put_line_img(a, b, data, z);
		x++;
		z = 0;
	}
	return (1);
}

int		ft_trace_vert(char **sstr_start, char **sstr_end, t_data *data, int y)
{
	int x;
	int z;
	t_coord a;
	t_coord b;

	x = 1;
	z = 0;
	while (x < data->wc + 1)
	{
		z = ft_get_nbr(sstr_start[x]);
		a.x = ft_coordx(*data, x, y, z);
		a.y = ft_coordy(*data, x, y, z);
		z = ft_get_nbr(sstr_end[x]);
		b.x = ft_coordx(*data, x, y + 10, z);
		b.y = ft_coordy(*data, x, y + 10, z);
		z = (z > ft_get_nbr(sstr_start[x]) ? z : ft_get_nbr(sstr_start[x]));
		ft_put_line_img(a, b, data, z);
		x++;
		z = 0;
	}
	return (1);
}