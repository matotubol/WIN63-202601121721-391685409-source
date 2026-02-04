package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Point;
   
   public class ChatFlowStage implements class_13, class_31
   {
      
      public static const MOVE_UP_AMOUNT_PIXELS:int = 19;
      
      private static const CLEANUP_TIMER_DELAY:int = 5000;
      
      private static const MOVE_UP_TIMER_DEFAULT:int = 10000;
      
      private static const MAX_ITERATIONS:int = 20;
      
      private static const MAX_COLLISION_SIDEWAYS_IMPULSE:int = 15;
      
      private static const MOVE_UP_IMPULSE_LIMIT:Number = 8;
      
      private const MINIMUM_COLLIDER_WIDTH:int = 240;
      
      private var var_59:HabboFreeFlowChat;
      
      private var _simulationTime:uint = 0;
      
      private var var_3077:uint = 0;
      
      private var var_4549:uint = 0;
      
      private var var_2034:class_3255 = new class_3255();
      
      private var var_223:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
      
      private var _toRemove:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
      
      private var var_1316:Boolean = false;
      
      private var var_1934:int = 10000;
      
      private var var_3817:Boolean = true;
      
      private var var_5404:Boolean = false;
      
      private var var_1328:int = 0;
      
      public function ChatFlowStage(param1:HabboFreeFlowChat)
      {
         super();
         var_59 = param1;
         var_59.registerUpdateReceiver(this,2);
         refreshSettings();
      }
      
      public function refreshSettings() : void
      {
         if(var_59.roomChatSettings)
         {
            var_1316 = var_59.roomChatSettings.mode == 1;
            var_3817 = !var_1316;
            switch(var_59.roomChatSettings.scrollSpeed)
            {
               case 0:
                  var_1934 = 3000;
                  break;
               case 1:
                  var_1934 = 6000;
                  break;
               case 2:
                  var_1934 = 12000;
            }
         }
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_59)
            {
               var_59.removeUpdateReceiver(this);
               var_59 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_59 == null;
      }
      
      public function insertBubble(param1:PooledChatBubble) : Point
      {
         var _loc11_:ChatBubbleSimulationEntity = null;
         var _loc3_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         if(var_1328 == 0)
         {
            var_1328 = var_59.chatFlowViewer.viewBottom;
         }
         if(!var_1316 && param1.width < 240)
         {
            _loc11_ = new ChatBubbleSimulationWithLimitedWideRect(param1);
         }
         else
         {
            _loc11_ = new ChatBubbleSimulationEntity(param1,var_1316);
         }
         var _loc9_:Point = new Point(param1.userScreenPos.x - _loc11_.visualRect.width / 2,var_59.chatFlowViewer.viewBottom);
         var _loc4_:Point = var_59.roomEngine.getRoomCanvasScreenOffset(param1.roomId);
         if(_loc4_ != null)
         {
            _loc9_.x -= _loc4_.x;
         }
         _loc9_.y -= param1.overlap ? param1.overlap.y : 0;
         _loc9_.x -= param1.overlap ? param1.overlap.x : 0;
         _loc11_.initializePosition(_loc9_.x,_loc9_.y);
         if(!(var_3817 && !var_1316))
         {
            var_223.push(_loc11_);
            _loc9_.x -= param1.overlap ? param1.overlap.x : 0;
            if(var_1316)
            {
               var_3077 = _simulationTime;
            }
            return _loc9_;
         }
         var _loc6_:int = 0;
         while(true)
         {
            _loc3_ = 0;
            for each(var _loc7_ in var_223)
            {
               _loc3_ += var_2034.getAttraction(_loc11_,_loc7_,60,40);
            }
            _loc11_.x += _loc3_;
            _loc6_++;
         }
      }
      
      public function update(param1:uint) : void
      {
         var _loc3_:int = 0;
         var _loc2_:ChatBubbleSimulationEntity = null;
         _simulationTime += param1;
         simulate();
         if(var_3077 + var_1934 < _simulationTime)
         {
            scrollUp();
            var_3077 = _simulationTime;
         }
         _loc3_ = 0;
         while(_loc3_ < var_223.length)
         {
            _loc2_ = var_223[_loc3_];
            _loc2_.syncToVisualization();
            if(!_loc2_.isSpacer)
            {
               _loc2_.fullHeightCollision = false;
               if(_loc3_ > 0 && _loc2_.visualizationHasHitMargin)
               {
                  _loc2_.fullHeightCollision = true;
                  var_223[int(_loc3_ - 1)].fullHeightCollision = true;
               }
            }
            _loc3_++;
         }
         if(var_4549 + 5000 < _simulationTime)
         {
            cleanup();
            var_4549 = _simulationTime;
         }
      }
      
      public function clear() : void
      {
         for each(var _loc1_ in var_223)
         {
            _loc1_.readyToRecycle = true;
         }
         update(0);
         var_59.chatFlowViewer.update(0);
      }
      
      private function simulate() : void
      {
         var _loc7_:* = undefined;
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc11_:* = null;
         var _loc4_:* = null;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc1_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc8_:Number = NaN;
         _loc9_ = 0;
         while(_loc9_ < 20)
         {
            _loc7_ = new Vector.<ChatBubbleCollisionEvent>(0);
            for each(_loc11_ in var_223)
            {
               _loc11_.resetSimulationStep();
               for each(_loc4_ in var_223)
               {
                  if(_loc11_ != _loc4_ && _loc11_.intersectsWith(_loc4_))
                  {
                     _loc7_.push(new ChatBubbleCollisionEvent(_loc11_,_loc4_));
                  }
               }
            }
            if(_loc7_.length == 0)
            {
               break;
            }
            if(var_1316)
            {
               for each(_loc2_ in _loc7_)
               {
                  if(!_loc2_.first.hasCollidedWith(_loc2_.second) && !_loc2_.second.hasCollidedWith(_loc2_.first))
                  {
                     if(_loc2_.areSameY)
                     {
                        _loc2_.older.addVerticalImpulse(-_loc2_.older.wideRect.height);
                     }
                     else
                     {
                        _loc6_ = _loc2_.first.visualIntertersectsWith(_loc2_.second) ? _loc2_.top.visualRect.bottom : _loc2_.top.wideRect.bottom;
                        _loc2_.top.addVerticalImpulse(-(_loc6_ - _loc2_.bottom.y + 1));
                     }
                  }
                  _loc2_.first.addCollisionHandled(_loc2_.second);
                  _loc2_.second.addCollisionHandled(_loc2_.first);
               }
            }
            else
            {
               for each(_loc2_ in _loc7_)
               {
                  if(!_loc2_.first.hasCollidedWith(_loc2_.second) && !_loc2_.second.hasCollidedWith(_loc2_.first))
                  {
                     _loc1_ = _loc2_.left is ChatBubbleSimulationWithLimitedWideRect ? ChatBubbleSimulationWithLimitedWideRect(_loc2_.left).wideRectOffset + _loc2_.left.x : _loc2_.left.x;
                     _loc10_ = _loc2_.right is ChatBubbleSimulationWithLimitedWideRect ? ChatBubbleSimulationWithLimitedWideRect(_loc2_.right).wideRectOffset + _loc2_.right.x : _loc2_.right.x;
                     _loc3_ = _loc2_.left is ChatBubbleSimulationWithLimitedWideRect ? _loc2_.left.wideRect.width : _loc2_.left.visualRect.width;
                     _loc8_ = Math.abs(_loc1_ + _loc3_ - _loc10_) / 2;
                     if(_loc8_ <= 15)
                     {
                        _loc2_.left.addHorizontalImpulse(-_loc8_);
                        _loc2_.right.addHorizontalImpulse(_loc8_ + 1);
                     }
                     else if(_loc2_.areSameY)
                     {
                        _loc2_.older.addVerticalImpulse(-_loc2_.older.visualRect.height);
                     }
                     else
                     {
                        _loc2_.top.addVerticalImpulse(-(_loc2_.top.visualRect.bottom - _loc2_.bottom.y + 1));
                     }
                     _loc2_.first.addCollisionHandled(_loc2_.second);
                     _loc2_.second.addCollisionHandled(_loc2_.first);
                  }
               }
            }
            for each(_loc5_ in var_223)
            {
               _loc5_.applyImpulseForces(8);
            }
            _loc9_++;
         }
      }
      
      private function scrollUp() : void
      {
         if(var_59.chatFlowViewer == null)
         {
            return;
         }
         for each(var _loc1_ in var_223)
         {
            if(var_3817)
            {
               for each(var _loc2_ in var_223)
               {
                  if(_loc1_ != _loc2_)
                  {
                     _loc1_.x += var_2034.getAttraction(_loc1_,_loc2_);
                  }
               }
            }
            _loc1_.y -= 19;
         }
         if(var_1316)
         {
            insertBubble(var_59.chatBubbleFactory.getNewEmptySpace(19));
            var_223[var_223.length - 1].fullHeightCollision = true;
            var_223[var_223.length - 1].isSpacer = true;
         }
         simulate();
      }
      
      private function cleanup() : void
      {
         var _loc3_:int = 0;
         for each(var _loc1_ in var_223)
         {
            if(_loc1_.visualRect.bottom < -10 || _loc1_.readyToRecycle)
            {
               _loc1_.readyToRecycle = true;
               if(_toRemove.indexOf(_loc1_) == -1)
               {
                  _toRemove.push(_loc1_);
               }
            }
         }
         if(_toRemove.length > 0)
         {
            for each(var _loc2_ in _toRemove)
            {
               _loc3_ = int(var_223.indexOf(_loc2_));
               _loc2_.dispose();
               var_223.splice(_loc3_,1);
            }
            _toRemove = new Vector.<ChatBubbleSimulationEntity>(0);
         }
      }
      
      public function resize(param1:int, param2:int) : void
      {
         if(!var_59)
         {
            return;
         }
         if(!var_59.chatFlowViewer)
         {
            return;
         }
         var _loc5_:int = var_59.chatFlowViewer.viewBottom;
         if(var_1328 != _loc5_)
         {
            if(var_1328 < _loc5_)
            {
               var _loc4_:int = _loc5_ - var_1328;
               for each(var _loc3_ in var_223)
               {
                  null.y += 0;
                  null.syncToVisualization(true);
               }
            }
            else
            {
               var _loc6_:int = var_1328 - _loc5_;
               for each(_loc3_ in var_223)
               {
                  null.y -= 0;
                  null.syncToVisualization(true);
               }
            }
         }
         var_1328 = _loc5_;
      }
   }
}

