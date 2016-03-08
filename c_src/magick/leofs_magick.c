#include "erl_nif.h"

#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>

#include <wand/magick_wand.h>

//#include "queue.h"

const int IMG_RESIZES[3][2]={{80, 80}, {320, 320}, {640, 640}};

int width, height, array_len;
long unsigned int img_size=0;
unsigned long img_quality_num;

//typedef enum {
//    cmd_unknown,
//    cmd_convert
//} command_type;
//
//typedef struct {
//    command_type type;
//
//    ErlNifEnv *env;
//    ErlNifPid pid;
//    ERL_NIF_TERM arg;
//} magick_command;
//
//static void
//command_destroy(void *obj)
//{
//    magick_command *cmd = (magick_command *) obj;
//
//    if(cmd->env != NULL)
//	   enif_free_env(cmd->env);
//
//    enif_free(cmd);
//}
//
//static magick_command *
//command_create()
//{
//    magick_command *cmd = (magick_command *) enif_alloc(sizeof(magick_command));
//    if(cmd == NULL)
//	   return NULL;
//
//    cmd->env = enif_alloc_env();
//    if(cmd->env == NULL) {
//	    command_destroy(cmd);
//        return NULL;
//    }
//
//    cmd->type = cmd_unknown;
//    cmd->arg = 0;
//
//    return cmd;
//}
//
//static ERL_NIF_TERM
//push_command(ErlNifEnv *env, magick_command *cmd) {
//    if(!queue_push(cmd))
//        return enif_make_int(env, 2);
//
//    return enif_make_atom(env, "ok");
//}

static ERL_NIF_TERM
do_covnert(ErlNifEnv *env, const ERL_NIF_TERM argv[])
{
    InitializeMagick(NULL);
    ErlNifBinary bin;
    enif_inspect_binary(env, argv[0], &bin);

    MagickWand *magick_wand = NewMagickWand();
    MagickWand *wand;

    MagickReadImageBlob(magick_wand, bin.data, bin.size);

    img_quality_num = (unsigned long)MagickGetImageAttribute(magick_wand, "JPEG-Quality");
    if( img_quality_num > 75)
    {
        img_quality_num = 75;
    }

    array_len = sizeof(IMG_RESIZES)/sizeof(int)/2;

    ERL_NIF_TERM r = enif_make_list(env, 0);
    ErlNifBinary h;

    for(int i=0;i<1;i++)
    {
        for(int m=0; m<array_len;m++)
        {
                wand = CloneMagickWand(magick_wand);
                width = IMG_RESIZES[m][0];
                height = (int)(MagickGetImageHeight(wand)*width/MagickGetImageWidth(wand)+0.5);
                MagickSetCompressionQuality(wand, img_quality_num);

                MagickResizeImage(wand, width, height, DefaultThumbnailFilter,1.0);

//                printf("222...num:%ld...width:%d...height:%d...image_size:%ld...\n",img_quality_num, width, height, MagickGetImageSize(wand));
                unsigned char *blob;
                blob = MagickWriteImageBlob(wand,&img_size),
                img_size = MagickGetImageSize(wand);
//                printf("img size:%ld\n", img_size);

                enif_alloc_binary(img_size, &h);
                memcpy(h.data, blob, img_size);
                r = enif_make_list_cell(env, enif_make_binary(env, &h), r);
                DestroyMagickWand(wand);
                free(blob);
        }
    }

    ERL_NIF_TERM result;
    enif_make_reverse_list(env, r, &result);
    DestroyMagickWand(magick_wand);
    DestroyMagick();

    return result;
//    enif_schedule_dirty_nif_finalizer(env, result, enif_dirty_nif_finalizer);
}


//static ERL_NIF_TERM
//push_command(ErlNifEnv *env, esqlite_command *cmd) {
//    if(!queue_push(cmd))
//        return enif_make_int(env, 2);
//
//    return enif_make_int(env, 0);
//}


static ERL_NIF_TERM convert(ErlNifEnv* env, int argc, const ERL_NIF_TERM argv[])
{
//    magick_command *cmd = NULL;
//    ErlNifPid pid;
//
//    cmd = command_create();
//    if(!cmd)
//	    return enif_make_int(env, 1);
//
//    cmd->type = cmd_convert;
//    cmd->pid = pid;
//    cmd->arg = enif_make_copy(cmd->env, argv[0]);
//
//    return push_command(env, cmd);



    return do_covnert(env, argv);


}


static ErlNifFunc nif_funcs[] =
{
    {"convert", 1, convert, ERL_NIF_DIRTY_JOB_CPU_BOUND}
};

ERL_NIF_INIT(leofs_magick,nif_funcs,NULL,NULL,NULL,NULL)


