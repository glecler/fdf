NAME 	= fdf
SRC 	= sstr_link.m img_put.m parsing.m fdf.m get_next_line.m
FLAGS 	= -Wall -Wextra
DEBUG   = -fsanitize=address
CC 	= gcc
	CL=\x1b[35m
	GREEN=\033[1;32m
	RED=\033[1;31m
	CL2=\x1b[36m
	NC=\033[0m

all: $(NAME)

$(NAME): $(SRC)
	@$(CC) $(DEBUG) $(FLAGS) -I minilibx_macos $(SRC) ./libft/libft.a -L minilibx_macos -lmlx -framework OpenGL -framework Appkit -o fdf
	@echo "$(GREEN)[✓]$(NC)$(CL) $(NAME) built$(NC)"

clean:
	@rm -rf $(OBJ)
	@echo "$(RED)[-]$(NC)$(CL2) Objects of $(NAME) cleaned$(NC)"

fclean: clean
	@rm -rf fdf
	@echo "$(RED)[-]$(NC)$(CL2) fdf cleaned$(NC)"

re: fclean all

.PHONY: test, all, $(NAME), clean, fclean, re
