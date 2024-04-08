NAME := fdf
COMMON_FILES := \
	argb.c \
	bresenham.c \
	bresenham_draw_colored_line.c \
	bresenham_draw_colored_pixels.c \
	bresenham_normalize_coords.c \
	bresenham_utils.c \
	coord_conversion.c \
	events.c \
	funcs.c \
	gradient.c \
	helpers.c \
	hex_atoi.c \
	image.c \
	key_hooks.c \
	map.c \
	map_build.c \
	map_check.c \
	map_parse_data.c \
	map_populate_vertexes.c \
	map_utils.c \
	matrix.c \
	read_file.c \
	render.c \
	rotation.c \
	transform.c \
	transform_cavalier.c \
	transform_isometric.c \
	transform_utils.c

SRC_DIR := src
OBJ_DIR := build

FILES := main_isometric.c $(COMMON_FILES)
SRC := $(addprefix $(SRC_DIR)/, $(FILES))
OBJ := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC))

FILES_BONUS := main_cavalier.c $(COMMON_FILES)
SRC_BONUS := $(addprefix $(SRC_DIR)/, $(FILES_BONUS))
OBJ_BONUS := $(patsubst $(SRC_DIR)/%.c, $(OBJ_DIR)/%.o, $(SRC_BONUS))

MLX_INC := lib/minilibx-linux
MLX_STT := lib/minilibx-linux/libmlx.a
FT_INC := lib/libft/inc
FT_STT := lib/libft/lib/libft.a

CFLAGS := -Wall -Wextra -Werror


# -O3 highest optimization
$(OBJ_DIR)/%.o: $(SRC_DIR)/%.c
	@mkdir -p $(OBJ_DIR)
	$(CC) -I /usr/include -I$(MLX_INC) -I$(FT_INC) -O3 -c $< -o $@

# .SILENT:

all: $(NAME)

$(NAME): $(OBJ) $(MLX_STT) $(FT_STT)
	@rm -f bonus
	$(CC) $(OBJ) $(MLX_STT) $(FT_STT) -I$(MLX_INC) -I$(FT_INC) -l Xext -l X11 -lm -lz -o $@
	@echo "👏 Complete! 👏"

bonus: $(OBJ_BONUS) $(MLX_STT) $(FT_STT)
	touch bonus
	$(CC) $(OBJ_BONUS) $(MLX_STT) $(FT_STT) -I$(MLX_INC) -I$(FT_INC) -l Xext -l X11 -lm -lz -o $(NAME)
	@echo "👏 Complete! 👏"

$(FT_STT):
	$(MAKE) -C lib/libft

$(MLX_STT):
	$(MAKE) -C lib/minilibx-linux all

clean:
	rm -f ./$(OBJ_DIR)/*.o
	$(MAKE) -C lib/libft clean
	$(MAKE) -C lib/minilibx-linux clean


fclean: clean
	rm -f bonus
	rm -f fdf
	rm -f lib/libft/lib/libft.a
	rm -f lib/libft/lib/*.a

re: fclean all

.PHONY: all, clean, fclean, re
