LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

TARGET_PLATFORM=android-8

LOCAL_MODULE := libskia

LOCAL_ARM_MODE := arm

LOCAL_SRC_FILES := \
	$(addprefix src/core/, \
		Sk64.cpp \
		SkAAClip.cpp \
		SkAdvancedTypefaceMetrics.cpp \
		SkAlphaRuns.cpp \
		SkAnnotation.cpp \
		SkBBoxHierarchy.cpp \
		SkBBoxHierarchyRecord.cpp \
		SkBBoxRecord.cpp \
		SkBitmap.cpp \
		SkBitmapHeap.cpp \
		SkBitmapProcShader.cpp \
		SkBitmapProcState.cpp \
		SkBitmapProcState_matrixProcs.cpp \
		SkBitmapSampler.cpp \
		SkBitmap_scroll.cpp \
		SkBlitMask_D32.cpp \
		SkBlitRow_D16.cpp \
		SkBlitRow_D32.cpp \
		SkBlitRow_D4444.cpp \
		SkBlitter.cpp \
		SkBlitter_4444.cpp \
		SkBlitter_A1.cpp \
		SkBlitter_A8.cpp \
		SkBlitter_ARGB32.cpp \
		SkBlitter_RGB16.cpp \
		SkBlitter_Sprite.cpp \
		SkBuffer.cpp \
		SkCanvas.cpp \
		SkChunkAlloc.cpp \
		SkClipStack.cpp \
		SkColor.cpp \
		SkColorFilter.cpp \
		SkColorTable.cpp \
		SkComposeShader.cpp \
		SkConcaveToTriangles.cpp \
		SkConfig8888.cpp \
		SkCordic.cpp \
		SkCubicClipper.cpp \
		SkData.cpp \
		SkDebug.cpp \
		SkDeque.cpp \
		SkDevice.cpp \
		SkDeviceProfile.cpp \
		SkDither.cpp \
		SkDraw.cpp \
		SkEdge.cpp \
		SkEdgeBuilder.cpp \
		SkEdgeClipper.cpp \
		SkFilterProc.cpp \
		SkFlate.cpp \
		SkFlattenable.cpp \
		SkFlattenableBuffers.cpp \
		SkFloat.cpp \
		SkFloatBits.cpp \
		SkFontHost.cpp \
		SkGeometry.cpp \
		SkGlyphCache.cpp \
		SkGraphics.cpp \
		SkImageFilter.cpp \
		SkInstCnt.cpp \
		SkLineClipper.cpp \
		SkMMapStream.cpp \
		SkMallocPixelRef.cpp \
		SkMask.cpp \
		SkMaskFilter.cpp \
		SkMaskGamma.cpp \
		SkMath.cpp \
		SkMatrix.cpp \
		SkMemory_stdlib.cpp \
		SkMetaData.cpp \
		SkOrderedReadBuffer.cpp \
		SkOrderedWriteBuffer.cpp \
		SkPackBits.cpp \
		SkPaint.cpp \
		SkPath.cpp \
		SkPathEffect.cpp \
		SkPathHeap.cpp \
		SkPathMeasure.cpp \
		SkPicture.cpp \
		SkPictureFlat.cpp \
		SkPicturePlayback.cpp \
		SkPictureRecord.cpp \
		SkPictureStateTree.cpp \
		SkPixelRef.cpp \
		SkPoint.cpp \
		SkProcSpriteBlitter.cpp \
		SkPtrRecorder.cpp \
		SkQuadClipper.cpp \
		SkRRect.cpp \
		SkRTree.cpp \
		SkRasterClip.cpp \
		SkRasterizer.cpp \
		SkRect.cpp \
		SkRefCnt.cpp \
		SkRefDict.cpp \
		SkRegion.cpp \
		SkRegion_path.cpp \
		SkRegion_rects.cpp \
		SkScalar.cpp \
		SkScalerContext.cpp \
		SkScan.cpp \
		SkScan_AntiPath.cpp \
		SkScan_Antihair.cpp \
		SkScan_Hairline.cpp \
		SkScan_Path.cpp \
		SkShader.cpp \
		SkSpriteBlitter_ARGB32.cpp \
		SkSpriteBlitter_RGB16.cpp \
		SkStream.cpp \
		SkString.cpp \
		SkStroke.cpp \
		SkStrokeRec.cpp \
		SkStrokerPriv.cpp \
		SkTLS.cpp \
		SkTSearch.cpp \
		SkTileGrid.cpp \
		SkTileGridPicture.cpp \
		SkTypeface.cpp \
		SkTypefaceCache.cpp \
		SkUnPreMultiply.cpp \
		SkUtils.cpp \
		SkUtilsArm.cpp \
		SkWriter32.cpp \
		SkXfermode.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/effects/gradients/, \
		SkBitmapCache.cpp \
		SkClampRange.cpp \
		SkGradientShader.cpp \
		SkLinearGradient.cpp \
		SkRadialGradient.cpp \
		SkSweepGradient.cpp \
		SkTwoPointConicalGradient.cpp \
		SkTwoPointRadialGradient.cpp \
		)
		
LOCAL_SRC_FILES+=$(addprefix src/effects/, \
		SkDashPathEffect.cpp \
		SkColorFilters.cpp \
		SkSingleInputImageFilter.cpp \
		SkLayerDrawLooper.cpp \
		SkBlurMask.cpp \
		SkBlurMaskFilter.cpp \
		SkOffsetImageFilter.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/image/, \
		SkDataPixelRef.cpp \
		SkImage.cpp \
		SkImagePriv.cpp \
		SkImage_Codec.cpp \
		SkImage_Picture.cpp \
		SkImage_Raster.cpp \
		SkSurface.cpp \
		SkSurface_Picture.cpp \
		SkSurface_Raster.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/opts/, \
		SkBitmapProcState_opts_none.cpp \
		SkBlitRow_opts_none.cpp \
		SkUtils_opts_none.cpp \
		)
		
LOCAL_SRC_FILES+=$(addprefix src/ports/, \
		FontHostConfiguration_android.cpp \
		SkDebug_android.cpp \
		SkFontDescriptor.cpp \
		SkFontHost_android.cpp \
		SkFontHost_FreeType.cpp \
		SkFontHost_FreeType_common.cpp \
		SkFontHost_tables.cpp \
		SkOSFile_stdio.cpp \
		SkThread_pthread.cpp \
		SkTime_Unix.cpp \
		)

LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/src/core \
		$(LOCAL_PATH)/src/image \
		$(LOCAL_PATH)/include/images \
		$(LOCAL_PATH)/include/core \
		$(LOCAL_PATH)/include/effects \
		$(LOCAL_PATH)/include/config \
		$(LOCAL_PATH)/include/ports \
		$(LOCAL_PATH)/include/utils \
		$(LOCAL_PATH)/../libfreetype/include \
		$(LOCAL_PATH)/../libexpat/lib

LOCAL_CFLAGS := -DSK_BUILD_FOR_ANDROID -DSK_BUILD_FOR_ANDROID_NDK

include $(BUILD_STATIC_LIBRARY)
