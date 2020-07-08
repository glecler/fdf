/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   sstr_link.c                                        :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: glecler <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/10/28 14:39:28 by glecler           #+#    #+#             */
/*   Updated: 2019/11/03 01:10:10 by glecler          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/fdf.h"

float	ft_coordx(t_data data, int x, int y, int z)
{
	if (data.rep == 1)
		return (((10 * x) - y));
	else
		return (10 * x - cos(45) * z * data.vol);
	return (0);
}

float	ft_coordy(t_data data, int x, int y, int z)
{
	if (data.rep == 1)
		return (((10 * x) + y - z * data.vol));
	else
		return (y + sin(45) * z * data.vol);
	return (0);
}

int		ft_trace_sstr(char **sstr, t_data *data, int y)
{
	int		x;
	int		z;
	t_coord	a;
	t_coord	b;

	x = 0;
	z = 0;
	while (x < data->wc - 1)
	{
		z = ft_get_nbr(sstr[x]);
		a.x = ft_coordx(*data, x, y, z);
		a.y = ft_coordy(*data, x, y, z);
		z = ft_get_nbr(sstr[x + 1]);
		b.x = ft_coordx(*data, x + 1, y, z);
		b.y = ft_coordy(*data, x + 1, y, z);
		z = (z > ft_get_nbr(sstr[x]) ? z : ft_get_nbr(sstr[x]));
		ft_put_line_img(a, b, data, z);
		x++;
		z = 0;
	}
	return (1);
}

int		ft_trace_vert(char **sstr_start, char **sstr_end, t_data *data, int y)
{
	int		x;
	int		z;
	t_coord	a;
	t_coord	b;

	x = 0;
	z = 0;
	while (x < data->wc)
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
