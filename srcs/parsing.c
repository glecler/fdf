/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   parsing.c                                          :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: glecler <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/10/28 14:32:43 by glecler           #+#    #+#             */
/*   Updated: 2019/11/03 01:09:47 by glecler          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/fdf.h"

int		ft_count_line_map(char **sstr)
{
	int i;
	int j;

	j = 0;
	i = 0;
	while (sstr[i] != 0)
	{
		while (sstr[i][j] != 0)
			j++;
		i++;
		j = 0;
	}
	return (i);
}

char	**ft_get_map(char **av)
{
	int		fd;
	int		i;
	char	**map;
	int		maxlen;

	i = 0;
	map = NULL;
	fd = open(av[1], O_RDONLY);
	maxlen = ft_line_count(av[1], fd);
	if (maxlen == 0)
		return (0);
	if (!(map = (char**)malloc(sizeof(char*) *
		(maxlen + 1))))
		return (0);
	while (i < maxlen)
	{
		get_next_line(fd, &(map[i]));
		i++;
	}
	map[i] = 0;
	return (map);
}

int		ft_line_count(char *file, int fd)
{
	int		lc;
	int		i;
	int		x;
	char	buff[20 + 1];

	i = 0;
	lc = 0;
	x = 0;
	fd = open(file, O_RDONLY);
	while ((x = read(fd, buff, 20)) > 0)
	{
		buff[x] = 0;
		while (buff[i])
		{
			if (buff[i] == '\n')
				lc++;
			i++;
		}
		i = 0;
	}
	close(fd);
	return (lc);
}

void	ft_check_map(char **map)
{
	size_t	len;
	int		i;
	int		j;

	i = 0;
	len = 0;
	j = ft_word_count(map[i]);
	while (map[i])
	{
		if (ft_word_count(map[i]) != j)
		{
			ft_putstr("Error : Found wrong line length. Exiting.\n");
			free(map);
			exit(1);
		}
		if (j == 0)
		{
			ft_putstr("Error : Empty file.\n");
			free(map);
			exit(1);
		}
		i++;
	}
}

int		ft_word_count(char *str)
{
	int i;
	int x;
	int j;

	j = 0;
	i = 0;
	x = 0;
	if (!(str))
		return (0);
	while (str[i])
	{
		if (str[i] && str[i] != ' ' && str[i] != '\t' && str[i] != '\n')
		{
			while (str[i] && str[i] != ' ' && str[i] != '\t' && str[i] != '\n')
				i++;
			x++;
		}
		i++;
	}
	return (x);
}
