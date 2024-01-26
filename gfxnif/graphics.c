#include <assert.h>
#include <pthread.h>
#include <SDL.h>


static pthread_mutex_t ready_mutex;
static pthread_cond_t ready_cond;
static SDL_Window *window;
static SDL_Surface *surface;
static SDL_Rect screen = {.x = 0, .y = 0};


static void* init_wait_for_quit(void *)
{
    SDL_Init(SDL_INIT_VIDEO);
    window = SDL_CreateWindow("eray",
                              SDL_WINDOWPOS_CENTERED,
                              SDL_WINDOWPOS_CENTERED,
                              screen.w, screen.h,
                              SDL_WINDOW_SHOWN);
    surface = SDL_GetWindowSurface(window);

    /* we only support a specific pixel format below */
    SDL_PixelFormat* format = surface->format;
    assert(format->format == SDL_PIXELFORMAT_RGB888);
    assert(format->Rmask == 0xff0000);
    assert(format->Gmask == 0x00ff00);
    assert(format->Bmask == 0x0000ff);
    assert(format->Amask == 0x0);
    assert(format->BitsPerPixel == 32);
    assert(format->BytesPerPixel == 4);

    pthread_mutex_lock(&ready_mutex);
    pthread_cond_signal(&ready_cond);
    pthread_mutex_unlock(&ready_mutex);

    SDL_Event event;
    for (;;) {
        SDL_WaitEvent(&event);
        if (event.type == SDL_QUIT) {
          printf("QUIT event\n");
          break;
        }
    }

    printf("bye\n");
    exit(1);
    return NULL;
}


void gfx_init(int width, int height)
{
    screen.w = width;
    screen.h = height;

    pthread_t thread_id;
    pthread_create(&thread_id, NULL, init_wait_for_quit, NULL);

    pthread_mutex_lock(&ready_mutex);
    pthread_cond_wait(&ready_cond, &ready_mutex);
    pthread_mutex_unlock(&ready_mutex);
}


void gfx_set_pixel(int r, int g, int b, int x, int y)
{
     Uint32 pixel = (r << 16) | (g << 8) | b;
     size_t i = (y * surface->pitch) / sizeof(Uint32) + x;
     ((Uint32*)surface->pixels)[i] = pixel;
}


void gfx_clear_pixels()
{
    SDL_FillRect(surface, &screen, 0);
}


void gfx_update_window()
{
    SDL_UpdateWindowSurface(window);
}
