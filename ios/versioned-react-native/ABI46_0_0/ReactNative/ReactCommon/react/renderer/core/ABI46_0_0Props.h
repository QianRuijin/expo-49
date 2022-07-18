/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <folly/dynamic.h>

#include <ABI46_0_0React/ABI46_0_0renderer/core/PropsParserContext.h>
#include <ABI46_0_0React/ABI46_0_0renderer/core/RawProps.h>
#include <ABI46_0_0React/ABI46_0_0renderer/core/ABI46_0_0ReactPrimitives.h>
#include <ABI46_0_0React/ABI46_0_0renderer/core/Sealable.h>
#include <ABI46_0_0React/ABI46_0_0renderer/debug/DebugStringConvertible.h>

namespace ABI46_0_0facebook {
namespace ABI46_0_0React {

class Props;

using SharedProps = std::shared_ptr<Props const>;

/*
 * Represents the most generic props object.
 */
class Props : public virtual Sealable, public virtual DebugStringConvertible {
 public:
  using Shared = std::shared_ptr<Props const>;

  Props() = default;
  Props(
      const PropsParserContext &context,
      const Props &sourceProps,
      RawProps const &rawProps,
      bool shouldSetRawProps = true);
  virtual ~Props() = default;

  std::string nativeId;

  /*
   * Special value that represents generation number of `Props` object, which
   * increases when the object was constructed with some source `Props` object.
   * Default props objects (that was constructed using default constructor) have
   * revision equals `0`.
   * The value might be used for optimization purposes.
   */
  int const revision{0};

#ifdef ANDROID
  folly::dynamic rawProps = folly::dynamic::object();
#endif
};

} // namespace ABI46_0_0React
} // namespace ABI46_0_0facebook