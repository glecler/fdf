#include "./minilibx_macos/mlx.h"
#include <AppKit/AppKit.h>
#include <math.h>
#include "fdf.h"

void	trace(t_data *data, char **sstr, int y)
{
	int x, z, i;
	int xa, ya;
	t_coord a, b;
	int color, res;

	xa = 1;
	y *= 10;
	ya = y;
	i = 0;
	x = 0;
	while (x <= 60 && i < 10)
	{
		
		a.x = xa;
		a.y = ya;
		xa = lround((x - y) * cos(60));
		ya = lround((-(x + y) * sin(60))) + z;
		b.x = xa;
		b.y = ya;
		ft_put_line_img(a, b, data, color);
		i++;
		x += 10;
	}
}
