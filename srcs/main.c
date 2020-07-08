/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   main.c                                             :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: glecler <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/11/02 16:12:53 by glecler           #+#    #+#             */
/*   Updated: 2019/11/03 01:09:36 by glecler          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/fdf.h"

int		ft_abs(double d)
{
	if (d > 0)
		return (d);
	return (-1 * d);
}

void	ft_init_data(t_data *data)
{
	data->bpp = 24;
	data->endian = 0;
	data->color = 0;
	data->wc = ft_word_count((data->map)[0]);
	data->posx = 10 * ft_count_line_map(data->map);
	data->posy = 0;
	data->vol = 1;
	data->zoom = 1;
	data->step = 1;
	data->rep = 1;
	data->mlx_ptr = 0;
	data->img_ptr = 0;
	data->addr = 0;
	data->img_width = 10 * data->wc + data->posx;
	if (data->img_width > 2500)
		data->img_width = 2500;
	if (data->posx > 100)
		data->posx = 100;
	data->size_line = data->img_width * 3;
}

int		main(int ac, char **av)
{
	int		i;
	int		res;
	t_data	data;

	i = 0;
	if (ac != 2)
	{
		ft_putstr("Usage : ./fdf <filename>\n");
		return (0);
	}
	if (!(data.map = ft_get_map(av)))
		return (0);
	ft_check_map(data.map);
	ft_init_data(&data);
	data.mlx_ptr = mlx_init();
	i = ft_trace_fdf(&data, data.map);
	data.win_ptr = mlx_new_window(data.mlx_ptr,
		data.img_width, data.img_width, "fdf");
	res = mlx_put_image_to_window(data.mlx_ptr, data.win_ptr,
		data.img_ptr, 0, 0);
	mlx_key_hook(data.win_ptr, get_key, &(data));
	mlx_loop(data.mlx_ptr);
	free_buff(data.map, i);
	return (0);
}
