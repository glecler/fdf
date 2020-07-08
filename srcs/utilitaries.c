/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   utilitaries.c                                      :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: glecler <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/10/28 15:00:12 by glecler           #+#    #+#             */
/*   Updated: 2019/11/03 01:10:22 by glecler          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/fdf.h"

char			*ft_strncpy(char *dst, const char *src, size_t len)
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

char			*ft_cpy_str(char *str, int rang)
{
	int		x;
	int		i;
	char	*cpy;

	x = 0;
	i = 0;
	cpy = NULL;
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
	return (cpy);
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

char			**ft_split(char *str)
{
	int		x;
	int		i;
	char	**sstr;

	x = ft_word_count(str);
	i = 0;
	if (!(sstr = (char**)malloc(sizeof(char*) * (x + 1))))
		return (0);
	while (i < x)
	{
		if (!(sstr[i] = ft_cpy_str(str, i)))
			return (0);
		i++;
	}
	sstr[i] = 0;
	return (sstr);
}
