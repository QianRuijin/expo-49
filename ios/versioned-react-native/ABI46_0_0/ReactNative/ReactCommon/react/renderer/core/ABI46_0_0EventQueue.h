/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */

#pragma once

#include <memory>
#include <mutex>
#include <vector>

#include <ABI46_0_0jsi/ABI46_0_0jsi.h>
#include <ABI46_0_0React/ABI46_0_0renderer/core/EventBeat.h>
#include <ABI46_0_0React/ABI46_0_0renderer/core/EventQueueProcessor.h>
#include <ABI46_0_0React/ABI46_0_0renderer/core/RawEvent.h>
#include <ABI46_0_0React/ABI46_0_0renderer/core/StateUpdate.h>

namespace ABI46_0_0facebook {
namespace ABI46_0_0React {

/*
 * Event Queue synchronized with given Event Beat and dispatching event
 * using given Event Pipe.
 */
class EventQueue {
 public:
  EventQueue(
      EventQueueProcessor eventProcessor,
      std::unique_ptr<EventBeat> eventBeat);
  virtual ~EventQueue() = default;

  /*
   * Enqueues and (probably later) dispatch a given event.
   * Can be called on any thread.
   */
  void enqueueEvent(RawEvent &&rawEvent) const;

  /*
   * Enqueues and (probably later) dispatches a given event.
   * Deletes last RawEvent from the queue if it has the same type and target.
   * Can be called on any thread.
   */
  void enqueueUniqueEvent(RawEvent &&rawEvent) const;

  /*
   * Enqueues and (probably later) dispatch a given state update.
   * Can be called on any thread.
   */
  void enqueueStateUpdate(StateUpdate &&stateUpdate) const;

 protected:
  /*
   * Called on any enqueue operation.
   * Override in subclasses to trigger beat `request` and/or beat `induce`.
   * Default implementation does nothing.
   */
  virtual void onEnqueue() const = 0;
  void onBeat(jsi::Runtime &runtime) const;

  void flushEvents(jsi::Runtime &runtime) const;
  void flushStateUpdates() const;

  EventQueueProcessor eventProcessor_;

  const std::unique_ptr<EventBeat> eventBeat_;
  // Thread-safe, protected by `queueMutex_`.
  mutable std::vector<RawEvent> eventQueue_;
  mutable std::vector<StateUpdate> stateUpdateQueue_;
  mutable std::mutex queueMutex_;
  mutable bool hasContinuousEventStarted_{false};
};

} // namespace ABI46_0_0React
} // namespace ABI46_0_0facebook