#include "fdf.h"

int     test(int key, void *param)
{
    t_data *data;
    int res;
    data = param;
    if (key == 123)
        data->posx += 50;
    if (key == 124)
        data->posx -= 50;
    if (key == 125)
        data->posy -= 50;
    if (key == 126)
        data->posy += 50;
    if (key == 13)
        data->zoom += .2;
    if (key == 2 && data->zoom > .2)
        data->zoom -= .2;
    if (key == 53)
        exit (1);
    if (key == 36)
    {
        data->rep = 2;
        data->posx -= 300;
    }
    if (key == 51)
    {
        data->rep = 1;
        data->posx += 300;
    }
    if (key == 35)
        data->vol += 1;
    if (key == 37)
        data->vol -= 1;
    printf("key%d\n", key);
    mlx_destroy_image(data->mlx_ptr, data->img_ptr);
    res = ft_trace_fdf(data, data->map);
    res = mlx_put_image_to_window(data->mlx_ptr, data->win_ptr, data->img_ptr, 0, 0);
    return (0);
}

int main(int ac, char **av)
{
    int     i;
    int     res;
    t_data  data;

    i = 0;

    data.map = ft_get_map(ac, av);
    ft_check_map(data.map);
    ft_init_data(&data);
    data.mlx_ptr = mlx_init();
    res = ft_trace_fdf(&data, data.map);
    data.win_ptr = mlx_new_window(data.mlx_ptr, 2500, 1500, "fdf");
    res = mlx_put_image_to_window(data.mlx_ptr, data.win_ptr, data.img_ptr, 0, 0);
    mlx_key_hook(data.win_ptr, test, &(data));
    mlx_loop(data.mlx_ptr);
    free(data.map);
    while (1);
    return(0);
}