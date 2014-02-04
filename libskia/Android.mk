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
		SkBBoxHierarchyRecord.cpp \
		SkBBoxRecord.cpp \
		SkBitmap.cpp \
		SkBitmap_scroll.cpp \
		SkBitmapDevice.cpp \
		SkBitmapFilter.cpp \
		SkBitmapHeap.cpp \
		SkBitmapProcShader.cpp \
		SkBitmapProcState.cpp \
		SkBitmapProcState_matrixProcs.cpp \
		SkBitmapScaler.cpp \
		SkBlitMask_D32.cpp \
		SkBlitRow_D16.cpp \
		SkBlitRow_D32.cpp \
		SkBlitter.cpp \
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
		SkConfig8888.cpp \
		SkConvolver.cpp \
		SkCordic.cpp \
		SkCubicClipper.cpp \
		SkData.cpp \
		SkDataTable.cpp \
		SkDebug.cpp \
		SkDeque.cpp \
		SkDevice.cpp \
		SkDeviceLooper.cpp \
		SkDeviceProfile.cpp \
		SkDither.cpp \
		SkDraw.cpp \
		SkDrawLooper.cpp \
		SkEdge.cpp \
		SkEdgeBuilder.cpp \
		SkEdgeClipper.cpp \
		SkError.cpp \
		SkFilterProc.cpp \
		SkFilterShader.cpp \
		SkFlate.cpp \
		SkFlattenable.cpp \
		SkFlattenableBuffers.cpp \
		SkFlattenableSerialization.cpp \
		SkFloat.cpp \
		SkFloatBits.cpp \
		SkFontDescriptor.cpp \
		SkFontHost.cpp \
		SkFontStream.cpp \
		SkGeometry.cpp \
		SkGlyphCache.cpp \
		SkGraphics.cpp \
		SkImageFilter.cpp \
		SkImageFilterUtils.cpp \
		SkImageInfo.cpp \
		SkInstCnt.cpp \
		SkLineClipper.cpp \
		SkMallocPixelRef.cpp \
		SkMask.cpp \
		SkMaskFilter.cpp \
		SkMaskGamma.cpp \
		SkMath.cpp \
		SkMatrix.cpp \
		SkMetaData.cpp \
		SkMipMap.cpp \
		SkOrderedReadBuffer.cpp \
		SkOrderedWriteBuffer.cpp \
		SkPackBits.cpp \
		SkPaint.cpp \
		SkPaintOptionsAndroid.cpp \
		SkPaintPriv.cpp \
		SkPath.cpp \
		SkPathEffect.cpp \
		SkPathHeap.cpp \
		SkPathMeasure.cpp \
		SkPathRef.cpp \
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
		SkRasterClip.cpp \
		SkRasterizer.cpp \
		SkRect.cpp \
		SkRefDict.cpp \
		SkRegion.cpp \
		SkRegion_path.cpp \
		SkRegion_rects.cpp \
		SkRRect.cpp \
		SkRTree.cpp \
		SkScalar.cpp \
		SkScaledImageCache.cpp \
		SkScalerContext.cpp \
		SkScan.cpp \
		SkScan_Antihair.cpp \
		SkScan_AntiPath.cpp \
		SkScan_Hairline.cpp \
		SkScan_Path.cpp \
		SkShader.cpp \
		SkSpriteBlitter_ARGB32.cpp \
		SkSpriteBlitter_RGB16.cpp \
		SkStream.cpp \
		SkString.cpp \
		SkStringUtils.cpp \
		SkStroke.cpp \
		SkStrokeRec.cpp \
		SkStrokerPriv.cpp \
		SkTileGrid.cpp \
		SkTileGridPicture.cpp \
		SkTLS.cpp \
		SkTSearch.cpp \
		SkTypeface.cpp \
		SkTypefaceCache.cpp \
		SkUnPreMultiply.cpp \
		SkUtils.cpp \
		SkUtilsArm.cpp \
		SkValidatingReadBuffer.cpp \
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
		Sk1DPathEffect.cpp \
		Sk2DPathEffect.cpp \
		SkArithmeticMode.cpp \
		SkAvoidXfermode.cpp \
		SkBicubicImageFilter.cpp \
		SkBitmapSource.cpp \
		SkBlurDrawLooper.cpp \
		SkBlurImageFilter.cpp \
		SkBlurMask.cpp \
		SkBlurMaskFilter.cpp \
		SkColorFilterImageFilter.cpp \
		SkColorFilters.cpp \
		SkColorMatrix.cpp \
		SkColorMatrixFilter.cpp \
		SkComposeImageFilter.cpp \
		SkCornerPathEffect.cpp \
		SkDashPathEffect.cpp \
		SkDiscretePathEffect.cpp \
		SkDisplacementMapEffect.cpp \
		SkDropShadowImageFilter.cpp \
		SkEmbossMask.cpp \
		SkEmbossMaskFilter.cpp \
		SkGpuBlurUtils.cpp \
		SkKernel33MaskFilter.cpp \
		SkLayerDrawLooper.cpp \
		SkLayerRasterizer.cpp \
		SkLerpXfermode.cpp \
		SkLightingImageFilter.cpp \
		SkLumaColorFilter.cpp \
		SkMagnifierImageFilter.cpp \
		SkMatrixConvolutionImageFilter.cpp \
		SkMergeImageFilter.cpp \
		SkMorphologyImageFilter.cpp \
		SkOffsetImageFilter.cpp \
		SkPaintFlagsDrawFilter.cpp \
		SkPerlinNoiseShader.cpp \
		SkPictureImageFilter.cpp \
		SkPixelXorXfermode.cpp \
		SkPorterDuff.cpp \
		SkRectShaderImageFilter.cpp \
		SkStippleMaskFilter.cpp \
		SkTableColorFilter.cpp \
		SkTableMaskFilter.cpp \
		SkTestImageFilters.cpp \
		SkTileImageFilter.cpp \
		SkTransparentShader.cpp \
		SkXfermodeImageFilter.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/image/, \
		SkImage.cpp \
		SkImagePriv.cpp \
		SkImage_Codec.cpp \
		SkImage_Picture.cpp \
		SkImage_Raster.cpp \
		SkSurface.cpp \
		SkSurface_Picture.cpp \
		SkSurface_Raster.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/images/, \
		SkImageDecoder.cpp \
		SkImageDecoder_FactoryDefault.cpp \
		SkImageDecoder_FactoryRegistrar.cpp \
		SkImageEncoder.cpp \
		SkImageEncoder_Factory.cpp \
		SkImageRef.cpp \
		SkImageRefPool.cpp \
		SkImageRef_ashmem.cpp \
		SkImageRef_GlobalPool.cpp \
		SkImages.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/opts/, \
		SkBitmapProcState_opts_none.cpp \
		SkBlurImage_opts_none.cpp \
		SkBlitMask_opts_none.cpp \
		SkBlitRow_opts_none.cpp \
		SkMorphology_opts_none.cpp \
		SkUtils_opts_none.cpp \
		SkXfermode_opts_none.cpp \
		)
		
LOCAL_SRC_FILES+=$(addprefix src/pathops/, \
		SkAddIntersections.cpp \
		SkDCubicIntersection.cpp \
		SkDCubicLineIntersection.cpp \
		SkDCubicToQuads.cpp \
		SkDLineIntersection.cpp \
		SkDQuadImplicit.cpp \
		SkDQuadIntersection.cpp \
		SkDQuadLineIntersection.cpp \
		SkIntersections.cpp \
		SkOpAngle.cpp \
		SkOpContour.cpp \
		SkOpEdgeBuilder.cpp \
		SkOpSegment.cpp \
		SkPathOpsBounds.cpp \
		SkPathOpsCommon.cpp \
		SkPathOpsCubic.cpp \
		SkPathOpsDebug.cpp \
		SkPathOpsLine.cpp \
		SkPathOpsOp.cpp \
		SkPathOpsPoint.cpp \
		SkPathOpsQuad.cpp \
		SkPathOpsRect.cpp \
		SkPathOpsSimplify.cpp \
		SkPathOpsTriangle.cpp \
		SkPathOpsTypes.cpp \
		SkPathWriter.cpp \
		SkQuarticRoot.cpp \
		SkReduceOrder.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/ports/, \
		SkDebug_android.cpp \
		SkFontConfigInterface_android.cpp \
		SkFontConfigParser_android.cpp \
		SkFontHost_fontconfig.cpp \
		SkFontHost_FreeType.cpp \
		SkFontHost_FreeType_common.cpp \
		SkGlobalInitialization_default.cpp \
		SkMemory_malloc.cpp \
		SkOSFile_none.cpp \
		SkOSFile_stdio.cpp \
		SkTime_Unix.cpp \
		SkTLS_none.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/sfnt/, \
		SkOTTable_name.cpp \
		SkOTUtils.cpp \
		)

LOCAL_SRC_FILES+=$(addprefix src/utils/, \
		android/ashmem.cpp \
		)

LOCAL_C_INCLUDES := \
		$(LOCAL_PATH)/src/core \
		$(LOCAL_PATH)/src/image \
		$(LOCAL_PATH)/src/opts \
		$(LOCAL_PATH)/src/sfnt \
		$(LOCAL_PATH)/src/utils/ \
		$(LOCAL_PATH)/include/images \
		$(LOCAL_PATH)/include/core \
		$(LOCAL_PATH)/include/effects \
		$(LOCAL_PATH)/include/config \
		$(LOCAL_PATH)/include/pathops \
		$(LOCAL_PATH)/include/ports \
		$(LOCAL_PATH)/include/utils \
		$(LOCAL_PATH)/../libfreetype/include \
		$(LOCAL_PATH)/../libexpat/lib

LOCAL_CFLAGS := -DSK_BUILD_FOR_ANDROID -DSK_BUILD_FOR_ANDROID_NDK

include $(BUILD_STATIC_LIBRARY)
