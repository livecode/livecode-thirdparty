/*
 * Copyright 2016 Google Inc.
 *
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#ifndef SkRasterPipeline_DEFINED
#define SkRasterPipeline_DEFINED

#include "SkNx.h"
#include "SkTArray.h"
#include "SkTypes.h"
#include <functional>

/**
 * SkRasterPipeline provides a cheap way to chain together a pixel processing pipeline.
 *
 * It's particularly designed for situations where the potential pipeline is extremely
 * combinatoric: {N dst formats} x {M source formats} x {K mask formats} x {C transfer modes} ...
 * No one wants to write specialized routines for all those combinations, and if we did, we'd
 * end up bloating our code size dramatically.  SkRasterPipeline stages can be chained together
 * at runtime, so we can scale this problem linearly rather than combinatorically.
 *
 * Each stage is represented by a function conforming to a common interface, SkRasterPipeline::Fn,
 * and by an arbitrary context pointer.  Fn's arguments, and sometimes custom calling convention,
 * are designed to maximize the amount of data we can pass along the pipeline cheaply.
 * On many machines all arguments stay in registers the entire time.
 *
 * The meaning of the arguments to Fn are sometimes fixed:
 *    - The Stage* always represents the current stage, mainly providing access to ctx().
 *    - The first size_t is always the destination x coordinate.
 *      (If you need y, put it in your context.)
 *    - The second size_t is always tail: 0 when working on a full 4-pixel slab,
 *      or 1..3 when using only the bottom 1..3 lanes of each register.
 *    - By the time the shader's done, the first four vectors should hold source red,
 *      green, blue, and alpha, up to 4 pixels' worth each.
 *
 * Sometimes arguments are flexible:
 *    - In the shader, the first four vectors can be used for anything, e.g. sample coordinates.
 *    - The last four vectors are scratch registers that can be used to communicate between
 *      stages; transfer modes use these to hold the original destination pixel components.
 *
 * On some platforms the last four vectors are slower to work with than the other arguments.
 *
 * When done mutating its arguments and/or context, a stage can either:
 *   1) call st->next() with its mutated arguments, chaining to the next stage of the pipeline; or
 *   2) return, indicating the pipeline is complete for these pixels.
 *
 * Some stages that typically return are those that write a color to a destination pointer,
 * but any stage can short-circuit the rest of the pipeline by returning instead of calling next().
 */

// TODO: There may be a better place to stuff tail, e.g. in the bottom alignment bits of
// the Stage*.  This mostly matters on 64-bit Windows where every register is precious.

#define SK_RASTER_PIPELINE_STAGES(M)                             \
    M(trace) M(registers)                                        \
    M(move_src_dst) M(move_dst_src) M(swap_rb) M(swap_rb_d)      \
    M(clamp_0) M(clamp_a) M(clamp_1)                             \
    M(unpremul) M(premul)                                        \
    M(set_rgb)                                                   \
    M(from_srgb) M(from_srgb_d) M(to_srgb)                       \
    M(to_2dot2)                                                  \
    M(constant_color) M(store_f32)                               \
    M(load_565)  M(load_565_d)  M(store_565)                     \
    M(load_f16)  M(load_f16_d)  M(store_f16)                     \
    M(load_8888) M(load_8888_d) M(store_8888)                    \
    M(load_tables) M(store_tables)                               \
    M(scale_u8) M(scale_1_float)                                 \
    M(lerp_u8) M(lerp_565) M(lerp_1_float)                       \
    M(dstatop) M(dstin) M(dstout) M(dstover)                     \
    M(srcatop) M(srcin) M(srcout) M(srcover)                     \
    M(clear) M(modulate) M(multiply) M(plus_) M(screen) M(xor_)  \
    M(colorburn) M(colordodge) M(darken) M(difference)           \
    M(exclusion) M(hardlight) M(lighten) M(overlay) M(softlight) \
    M(luminance_to_alpha)                                        \
    M(matrix_2x3) M(matrix_3x4) M(matrix_4x5)                    \
    M(matrix_perspective)                                        \
    M(parametric_r) M(parametric_g) M(parametric_b)              \
    M(parametric_a)                                              \
    M(table_r) M(table_g) M(table_b) M(table_a)                  \
    M(color_lookup_table) M(lab_to_xyz)                          \
    M(clamp_x) M(mirror_x) M(repeat_x)                           \
    M(clamp_y) M(mirror_y) M(repeat_y)                           \
    M(gather_a8) M(gather_g8) M(gather_i8)                       \
    M(gather_565) M(gather_4444) M(gather_8888) M(gather_f16)    \
    M(top_left) M(top_right) M(bottom_left) M(bottom_right)      \
    M(accumulate)

class SkRasterPipeline {
public:
    // No pipeline may be more than kMaxStages long.
    static const int kMaxStages = 48;

    SkRasterPipeline();

    enum StockStage {
    #define M(stage) stage,
        SK_RASTER_PIPELINE_STAGES(M)
    #undef M
    };
    void append(StockStage, void* = nullptr);
    void append(StockStage stage, const void* ctx) { this->append(stage, const_cast<void*>(ctx)); }

    // Append all stages to this pipeline.
    void extend(const SkRasterPipeline&);

    // Runs the pipeline walking x through [x,x+n), holding y constant.
    void run(size_t x, size_t y, size_t n) const;

    // If you're going to run() the pipeline more than once, it's best to compile it.
    std::function<void(size_t x, size_t y, size_t n)> compile() const;

    void dump() const;

    struct Stage {
        StockStage stage;
        void*        ctx;
    };

private:
    int   fNum   = 0;
    Stage fStages[kMaxStages];
};

#endif//SkRasterPipeline_DEFINED
