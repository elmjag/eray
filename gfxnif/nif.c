#include <assert.h>
#include "erl_nif.h"
#include "graphics.h"


#define _get_int(env, term, ip) if (!enif_get_int(env, term, ip)) { return param_type_error_atom; }


ERL_NIF_TERM ok_atom;
ERL_NIF_TERM param_type_error_atom;


static int load(ErlNifEnv* env, void** priv_data, ERL_NIF_TERM load_info)
{
    ok_atom = enif_make_atom(env, "ok");
    param_type_error_atom = enif_make_atom(env, "param_type_error");
    return 0;
}

static ERL_NIF_TERM _wrap_gfx_init(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    int width, height;

    assert(argc == 2);

    _get_int(env, argv[0], &width);
    _get_int(env, argv[1], &height);

    gfx_init(width, height);

    return ok_atom;
}

static ERL_NIF_TERM _wrap_gfx_set_pixel(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    int r, g, b, x, y;

    assert(argc == 5);

    _get_int(env, argv[0], &r);
    _get_int(env, argv[1], &g);
    _get_int(env, argv[2], &b);
    _get_int(env, argv[3], &x);
    _get_int(env, argv[4], &y);

    gfx_set_pixel(r, g, b, x, y);

    return ok_atom;
}

static ERL_NIF_TERM _wrap_gfx_update_window(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    gfx_update_window();

    return ok_atom;
}

static ERL_NIF_TERM _wrap_gfx_clear_pixels(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
    gfx_clear_pixels();

    return ok_atom;
}

static ErlNifFunc nif_funcs[] = {
    {"init", 2, _wrap_gfx_init},
    {"set_pixel", 5, _wrap_gfx_set_pixel},
    {"update_window", 0, _wrap_gfx_update_window},
    {"clear_pixels", 0, _wrap_gfx_clear_pixels},
};

ERL_NIF_INIT(Elixir.Eray.Graphics, nif_funcs, load, NULL, NULL, NULL)
