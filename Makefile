NAME    = test
INC     = ./minilibx-linux# could be /usr/include depending on your OS
LIBMLX  = ./minilibx-linux/# could be /usr/lib, depends on where you decided to put your mlx library
UNAME   := $(shell uname)# get the OS name, this will help define behaviors for certain OS's
CFLAGS  = -Wall -Werror -Wextra -O3 -g -I$(INC) -Iinclude# C Flags (gcc) & linking. "-Iinclude" if you created the folder "include" to put your project headers"
LFLAGS  = -L$(LIBMLX) -lmlx # if you decided to install libmlx.a locally you don't need "-L$(LIBMLX) -lmlx" the school also has it locally as well...
SRC     = $(wildcard *.c)# list your source files
OBJ     = $(SRC:%.c=%.o)# convert source files to binary list
ifeq ($(UNAME), Darwin) # iMac / iOS

	CC = gcc
	LFLAGS += -framework OpenGL -framework AppKit
else ifeq ($(UNAME), FreeBSD) # FreeBSD
	CC = clang
else #Linux and others...
	CC = gcc
	LFLAGS += -lbsd -lXext -lX11 -lm
endif

all: $(NAME)

$(NAME): $(OBJ)
	$(CC) -o $(NAME) $(OBJ) $(LFLAGS)

clean:
	rm -f $(OBJ)
fclean: clean
	rm -f $(NAME)

re: fclean all

show:
	@printf "UNAME		: $(UNAME)\n"
	@printf "NAME  		: $(NAME)\n"
	@printf "CC		: $(CC)\n"
	@printf "CFLAGS		: $(CFLAGS)\n"
	@printf "LFLAGS		: $(LFLAGS)\n"
	@printf "SRC		: $(SRC)\n"
	@printf "OBJ		: $(OBJ)\n"
