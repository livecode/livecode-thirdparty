/*
 * Copyright 2016 Google Inc.
 *
 * Use of this source code is governed by a BSD-style license that can be
 * found in the LICENSE file.
 */

#include "SkOpts.h"
#include "SkRasterPipeline.h"

SkRasterPipeline::SkRasterPipeline() {}

void SkRasterPipeline::append(StockStage stage, void* ctx) {
#ifdef SK_DEBUG
    if (fNum == (int)SK_ARRAY_COUNT(fStages)) {
        this->dump();
    }
#endif
    SkASSERT(fNum < (int)SK_ARRAY_COUNT(fStages));
    fStages[fNum++] = { stage, ctx };
}

void SkRasterPipeline::extend(const SkRasterPipeline& src) {
    for (int i = 0; i < src.fNum; i++) {
        const Stage& s = src.fStages[i];
        this->append(s.stage, s.ctx);
    }
}

void SkRasterPipeline::run(size_t x, size_t y, size_t n) const {
    SkOpts::run_pipeline(x,y,n, fStages, fNum);
}

std::function<void(size_t, size_t, size_t)> SkRasterPipeline::compile() const {
    return SkOpts::compile_pipeline(fStages, fNum);
}

void SkRasterPipeline::dump() const {
    SkDebugf("SkRasterPipeline, %d stages\n", fNum);
    for (int i = 0; i < fNum; i++) {
        const char* name = "";
        switch (fStages[i].stage) {
        #define M(x) case x: name = #x; break;
            SK_RASTER_PIPELINE_STAGES(M)
        #undef M
        }
        SkDebugf("\t%s\n", name);
    }
    SkDebugf("\n");
}
