/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fdf.c                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: glecler <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/10/28 14:23:12 by glecler           #+#    #+#             */
/*   Updated: 2019/11/03 01:09:15 by glecler          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes//fdf.h"

t_data	ft_move(t_data data, int key)
{
	if (key == 123 && data.posx < data.img_width - 50)
		data.posx += 50;
	if (key == 124 && data.posx > -1 * data.img_width)
		data.posx -= 50;
	if (key == 125 && data.posy > -1 * data.img_width)
		data.posy -= 50;
	if (key == 126 && data.posy < data.img_width - 50)
		data.posy += 50;
	return (data);
}

t_data	ft_adjust(t_data data, int key)
{
	data.zoom += (key == 13 && data.zoom < 3 ? .2 : 0);
	data.zoom -= (key == 2 && data.zoom > .4 ? .2 : 0);
	if (key == 53)
	{
		free(data.map);
		exit(1);
	}
	if (key == 36 && data.rep == 1)
		data.rep = 2;
	if (key == 51 && data.rep == 2)
		data.rep = 1;
	data.vol += (key == 35 && data.vol < 3 ? 1 : 0);
	data.vol -= (key == 37 && data.vol > .4 ? 1 : 0);
	return (data);
}

int		get_key(int key, void *param)
{
	t_data	*data;
	int		res;

	data = param;
	if (key > 100)
		*data = ft_move(*data, key);
	if (key < 100)
		*data = ft_adjust(*data, key);
	mlx_destroy_image(data->mlx_ptr, data->img_ptr);
	res = ft_trace_fdf(data, data->map);
	res = mlx_put_image_to_window(data->mlx_ptr, data->win_ptr,
		data->img_ptr, 0, 0);
	return (0);
}

int		ft_trace_fdf(t_data *data, char **map)
{
	int		i;
	char	**buff_start;
	char	**buff_end;

	i = 0;
	data->img_ptr = mlx_new_image(data->mlx_ptr, data->img_width,
		data->img_width);
	data->addr = mlx_get_data_addr(data->img_ptr, &(data->bpp),
		&(data->size_line), &(data->endian));
	while (map[i])
	{
		if (!(buff_start = ft_split(map[i])))
			return (0);
		ft_trace_sstr(buff_start, data, i * 10);
		if (i > 0)
		{
			ft_trace_vert(buff_end, buff_start, data, (i - 1) * 10);
			free_buff(buff_end, data->wc);
		}
		if (!(buff_end = ft_split(map[i++])))
			return (0);
		free_buff(buff_start, data->wc);
	}
	free_buff(buff_end, data->wc);
	return (i);
}

void	free_buff(char **sstr, int wc)
{
	int i;

	i = 0;
	while (i < wc)
	{
		free(sstr[i]);
		i++;
	}
	free(sstr);
}
