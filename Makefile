NAME 	= fdf
SRC 	= ./srcs/sstr_link.c ./srcs/img_put.c ./srcs/parsing.c \
			./srcs/fdf.c ./srcs/utilitaries.c ./srcs/main.c
FLAGS 	= -Wall -Wextra -Werror 
CC		= gcc
	CL=\x1b[35m
	GREEN=\033[1;32m
	RED=\033[1;31m
	CL2=\x1b[36m
	NC=\033[0m

all: $(NAME)

$(NAME): $(SRC)
	@$(MAKE) -C srcs/libft
	@$(CC) $(FLAGS) -I minilibx_macos $(SRC) ./srcs/libft/libft.a -L ./includes/minilibx_macos -lmlx -framework OpenGL -framework Appkit -o fdf
	@echo "$(GREEN)[✓]$(NC)$(CL) $(NAME) built$(NC)"

clean:
	@rm -rf $(OBJ)
	@cd srcs/libft && $(MAKE) clean
	@echo "$(RED)[-]$(NC)$(CL2) Objects of $(NAME) cleaned$(NC)"

fclean: clean
	@cd srcs/libft && $(MAKE) fclean
	@rm -rf fdf
	@echo "$(RED)[-]$(NC)$(CL2) fdf cleaned$(NC)"

re: fclean all

.PHONY: test, all, $(NAME), clean, fclean, re
