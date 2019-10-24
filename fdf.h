#ifndef FDF_H
# define FDF_H

# include "./minilibx_macos/mlx.h"
# include <AppKit/AppKit.h>
# include <math.h>
# include "./libft/libft.h"
# include "get_next_line.h"
# include <stdlib.h>
# include <fcntl.h>
# define ABSOLU(x) (x > 0 ? x : -1 * x)
typedef struct  s_coord
{
	double      x;
	double      y;
}				t_coord;

typedef struct s_data
{
    int         bpp;
    int         endian;
    int         size_line;
    long int    color;
    int         wc;
    float       step;
    float       zoom;
    int         posx;
    int         posy;
    int         vol;
    int         rep;
    void        *mlx_ptr;
    void        *img_ptr;
    void        *win_ptr;
    char        *addr;
    char        **map;
}               t_data;

/* img_put.m */

int             ft_put_pixel_img(t_data *data, int x, int y, int z);
void            ft_put_line_img(t_coord a, t_coord b, t_data *data, int z);
void            ft_coord_swap(t_coord *a, t_coord *b);
void            ft_put_line_vert(t_coord a, t_coord b, t_data *data, int z);
int		        ft_color_pick(int z);

float       	ft_coordx(t_data data, int x, int y, int z);
float	        ft_coordy(t_data data, int x, int y, int z);

/* sstr_link */

int		        ft_trace_sstr(char **sstr, t_data *data, int y);
int		        ft_trace_vert(char **sstr_start, char **sstr_end, t_data *data, int y);

/* parsing.m */ 

void          ft_init_data(t_data *data);
int		        ft_trace_fdf(t_data *data, char **map);
int		        ft_line_count(char *file, int fd);
char	        **ft_get_map(int ac, char **av);
void	        ft_check_map(char **map);
char            **ft_split(char *str);
char            *ft_cpy_str(char *str, int rang);
int	            ft_word_count(char *str);
int				ft_get_nbr(char *str);
long long int   ft_pow(int base, int x);
char	        *ft_strncpy(char *dst, const char *src, size_t len);

#endif