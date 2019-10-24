#include "fdf.h"

int		ft_color_pick(int z)
{
	int color;

	if (z < 0)
		color = 254000000;
	if (z >= 0 && z <= 5)
		color = 254000;
	if (z > 5)
		color = 254;
	return (color);
}

int     ft_put_pixel_img(t_data *data, int x, int y, int z)
{
    int b;
    int i;
	char *cpy;
	int color;

	color = ft_color_pick(z);
	cpy = data->addr;
    b = data->bpp / 8;
    i = 0;
	if (y >= 5000 || x >= 5000 || x < 0 || y < 0)
		return (0);
    data->addr += y * data->size_line + x * b;
    while (i < 3)
    {
    	*((data->addr) + i) = color / ft_pow(10, 3 * (b - 2));
        color =  color - (color / ft_pow(10, 3 * (b - 2)) * ft_pow(10, 3 * (b - 2)));
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
	coeff = 0;
	a.x *= data->zoom;
	a.y *= data->zoom;
	b.x *= data->zoom;
	b.y *= data->zoom;
	if (b.x < a.x)
		ft_coord_swap(&a, &b);
	if (b.x != a.x)
		coeff = (b.y - a.y) / (b.x - a.x);
	if (b.x == a.x || ABSOLU(coeff) > 1)
		ft_put_line_vert(a, b, data, z);
	while ((a.x + x < b.x) && ABSOLU(coeff) <= 1)
	{
		y = ceil(x * coeff) + a.y;
		res = ft_put_pixel_img(data, ((a.x + x)) + data->posx, y + data->posy, z);
		x += data->step;
	}
}

void ft_put_line_vert(t_coord a, t_coord b, t_data *data, int z)
{
	int y;
	double x;
	int res;
	double coeff;

	coeff = 0;
	y = 0;
	x = a.x;
	if (a.y > b.y)
		ft_coord_swap(&a, &b);
	if (b.y != a.y)
		coeff = (b.x - a.x) / (b.y - a.y);
	while (a.y + y < b.y)
	{
		x = ceil(y * coeff) + a.x;
		res = ft_put_pixel_img(data, x + data->posx, (a.y + y) + data->posy, z);
		y += data->step;
	}
}

void	ft_coord_swap(t_coord *a, t_coord *b)
{
		a->x += b->x;
		b->x = a->x - b->x;
		a->x -= b->x;
		a->y += b->y;
		b->y = a->y - b->y;
		a->y -= b->y;
}