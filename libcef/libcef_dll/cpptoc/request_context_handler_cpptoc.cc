// Copyright (c) 2019 The Chromium Embedded Framework Authors. All rights
// reserved. Use of this source code is governed by a BSD-style license that
// can be found in the LICENSE file.
//
// ---------------------------------------------------------------------------
//
// This file was generated by the CEF translator tool. If making changes by
// hand only do so within the body of existing method and function
// implementations. See the translator.README.txt file in the tools directory
// for more information.
//
// $hash=2decd7941020bd2b96ebfa736624d1729a82fa55$
//

#include "libcef_dll/cpptoc/request_context_handler_cpptoc.h"
#include "libcef_dll/ctocpp/cookie_manager_ctocpp.h"
#include "libcef_dll/ctocpp/request_context_ctocpp.h"
#include "libcef_dll/ctocpp/web_plugin_info_ctocpp.h"

namespace {

// MEMBER FUNCTIONS - Body may be edited by hand.

void CEF_CALLBACK request_context_handler_on_request_context_initialized(
    struct _cef_request_context_handler_t* self,
    cef_request_context_t* request_context) {
  // AUTO-GENERATED CONTENT - DELETE THIS COMMENT BEFORE MODIFYING

  DCHECK(self);
  if (!self)
    return;
  // Verify param: request_context; type: refptr_diff
  DCHECK(request_context);
  if (!request_context)
    return;

  // Execute
  CefRequestContextHandlerCppToC::Get(self)->OnRequestContextInitialized(
      CefRequestContextCToCpp::Wrap(request_context));
}

cef_cookie_manager_t* CEF_CALLBACK request_context_handler_get_cookie_manager(
    struct _cef_request_context_handler_t* self) {
  // AUTO-GENERATED CONTENT - DELETE THIS COMMENT BEFORE MODIFYING

  DCHECK(self);
  if (!self)
    return NULL;

  // Execute
  CefRefPtr<CefCookieManager> _retval =
      CefRequestContextHandlerCppToC::Get(self)->GetCookieManager();

  // Return type: refptr_diff
  return CefCookieManagerCToCpp::Unwrap(_retval);
}

int CEF_CALLBACK request_context_handler_on_before_plugin_load(
    struct _cef_request_context_handler_t* self,
    const cef_string_t* mime_type,
    const cef_string_t* plugin_url,
    int is_main_frame,
    const cef_string_t* top_origin_url,
    struct _cef_web_plugin_info_t* plugin_info,
    cef_plugin_policy_t* plugin_policy) {
  // AUTO-GENERATED CONTENT - DELETE THIS COMMENT BEFORE MODIFYING

  DCHECK(self);
  if (!self)
    return 0;
  // Verify param: mime_type; type: string_byref_const
  DCHECK(mime_type);
  if (!mime_type)
    return 0;
  // Verify param: plugin_info; type: refptr_diff
  DCHECK(plugin_info);
  if (!plugin_info)
    return 0;
  // Verify param: plugin_policy; type: simple_byaddr
  DCHECK(plugin_policy);
  if (!plugin_policy)
    return 0;
  // Unverified params: plugin_url, top_origin_url

  // Execute
  bool _retval = CefRequestContextHandlerCppToC::Get(self)->OnBeforePluginLoad(
      CefString(mime_type), CefString(plugin_url), is_main_frame ? true : false,
      CefString(top_origin_url), CefWebPluginInfoCToCpp::Wrap(plugin_info),
      plugin_policy);

  // Return type: bool
  return _retval;
}

}  // namespace

// CONSTRUCTOR - Do not edit by hand.

CefRequestContextHandlerCppToC::CefRequestContextHandlerCppToC() {
  GetStruct()->on_request_context_initialized =
      request_context_handler_on_request_context_initialized;
  GetStruct()->get_cookie_manager = request_context_handler_get_cookie_manager;
  GetStruct()->on_before_plugin_load =
      request_context_handler_on_before_plugin_load;
}

// DESTRUCTOR - Do not edit by hand.

CefRequestContextHandlerCppToC::~CefRequestContextHandlerCppToC() {}

template <>
CefRefPtr<CefRequestContextHandler> CefCppToCRefCounted<
    CefRequestContextHandlerCppToC,
    CefRequestContextHandler,
    cef_request_context_handler_t>::UnwrapDerived(CefWrapperType type,
                                                  cef_request_context_handler_t*
                                                      s) {
  NOTREACHED() << "Unexpected class type: " << type;
  return NULL;
}

template <>
CefWrapperType
    CefCppToCRefCounted<CefRequestContextHandlerCppToC,
                        CefRequestContextHandler,
                        cef_request_context_handler_t>::kWrapperType =
        WT_REQUEST_CONTEXT_HANDLER;
