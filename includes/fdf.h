/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   fdf.h                                              :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: glecler <marvin@42.fr>                     +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2019/10/28 15:02:47 by glecler           #+#    #+#             */
/*   Updated: 2019/11/03 01:11:43 by glecler          ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#ifndef FDF_H
# define FDF_H

# include "./minilibx_macos/mlx.h"
# include <math.h>
# include "../srcs/libft/libft.h"
# include <fcntl.h>

typedef	struct	s_coord
{
	double		x;
	double		y;
}				t_coord;

typedef	struct	s_data
{
	int			bpp;
	int			endian;
	int			size_line;
	long int	color;
	int			wc;
	float		step;
	float		zoom;
	int			posx;
	int			posy;
	int			vol;
	int			rep;
	void		*mlx_ptr;
	void		*img_ptr;
	void		*win_ptr;
	char		*addr;
	char		**map;
	int			img_width;
}				t_data;

/*
** fdf.c
*/

int				get_key(int key, void *param);
t_data			ft_move(t_data data, int key);
t_data			ft_adjust(t_data data, int key);
int				ft_trace_fdf(t_data *data, char **map);

/*
** img_put.c
*/

int				ft_put_pixel_img(t_data *data, int x, int y, int z);
void			ft_put_line_img(t_coord a, t_coord b, t_data *data, int z);
void			ft_coord_swap(t_coord *a, t_coord *b);
void			ft_put_line_vert(t_coord a, t_coord b, t_data *data, int z);
int				ft_color_pick(int z);

/*
** sstr_link.c
*/

float			ft_coordx(t_data data, int x, int y, int z);
float			ft_coordy(t_data data, int x, int y, int z);
int				ft_trace_sstr(char **sstr, t_data *data, int y);
int				ft_trace_vert(char **sstr_start, char **sstr_end,
					t_data *data, int y);
/*
** parsing.c
*/

int				ft_count_line_map(char **sstr);
int				ft_line_count(char *file, int fd);
char			**ft_get_map(char **av);
void			ft_check_map(char **map);
int				ft_word_count(char *str);

/*
** utilitaries.c
*/

char			*ft_strncpy(char *dst, const char *src, size_t len);
char			**ft_split(char *str);
int				ft_get_nbr(char *str);
long long int	ft_pow(int base, int x);
char			*ft_cpy_str(char *str, int rang);
void			ft_init_data(t_data *data);
int				ft_abs(double d);

/*
** get_next_line
*/

int				get_next_line(const int fd, char **line);
void			free_buff(char **sstr, int wc);

#endif
