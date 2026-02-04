package com.sulake.habbo.freeflowchat.viewer
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.core.runtime.class_31;
   import com.sulake.habbo.freeflowchat.HabboFreeFlowChat;
   import com.sulake.habbo.freeflowchat.viewer.simulation.ChatFlowStage;
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.geom.Point;
   
   public class ChatFlowViewer implements class_13, class_31
   {
      
      private const VIEW_BOTTOM_DEFAULT:int = 230;
      
      private var var_59:HabboFreeFlowChat;
      
      private var var_549:ChatFlowStage;
      
      private var _rootDisplayObject:DisplayObjectContainer;
      
      private var var_4871:int;
      
      private var var_3619:int = 0;
      
      private var _runTime:uint = 0;
      
      private var var_5362:Number = 0.25;
      
      private var var_223:Vector.<PooledChatBubble> = new Vector.<PooledChatBubble>(0);
      
      private var _toRemove:Vector.<PooledChatBubble> = new Vector.<PooledChatBubble>(0);
      
      public function ChatFlowViewer(param1:HabboFreeFlowChat, param2:ChatFlowStage)
      {
         super();
         _rootDisplayObject = new Sprite();
         var_59 = param1;
         var_59.registerUpdateReceiver(this,1);
         var_549 = param2;
      }
      
      public function dispose() : void
      {
         if(var_59)
         {
            var_59.removeUpdateReceiver(this);
            var_59 = null;
         }
         var_549 = null;
         _rootDisplayObject = null;
      }
      
      public function get disposed() : Boolean
      {
         return _rootDisplayObject == null && var_59 == null;
      }
      
      public function insertBubble(param1:PooledChatBubble, param2:Point) : void
      {
         param1.roomPanOffsetX = var_3619;
         var_223.push(param1);
         _rootDisplayObject.addChild(param1);
         param1.warpTo(param2.x,param2.y);
         param1.repositionPointer();
         var_4871 = param1.roomId;
      }
      
      public function update(param1:uint) : void
      {
         var _loc6_:int = 0;
         _runTime += param1;
         var _loc3_:Point = var_59.roomEngine.getRoomCanvasScreenOffset(var_4871);
         if(_loc3_ != null)
         {
            if(_loc3_.x != var_3619 && var_223.length > 0)
            {
               for each(var _loc2_ in var_223)
               {
                  _loc2_.roomPanOffsetX = _loc3_.x;
               }
            }
            var_3619 = _loc3_.x;
         }
         for each(var _loc4_ in var_223)
         {
            _loc4_.update(param1);
            if(_loc4_.readyToRecycle)
            {
               _toRemove.push(_loc4_);
            }
         }
         if(_toRemove.length > 0)
         {
            for each(var _loc5_ in _toRemove)
            {
               _rootDisplayObject.removeChild(_loc5_);
               _loc6_ = int(var_223.indexOf(_loc5_));
               var_223.splice(_loc6_,1);
               _loc5_.unregister();
               var_59.chatBubbleFactory.recycle(_loc5_);
            }
            _toRemove = new Vector.<PooledChatBubble>(0);
         }
      }
      
      public function get rootDisplayObject() : DisplayObjectContainer
      {
         return _rootDisplayObject;
      }
      
      public function get viewBottom() : int
      {
         if(!_rootDisplayObject.stage)
         {
            return 230;
         }
         return _rootDisplayObject.stage.stageHeight * var_5362;
      }
      
      public function resize(param1:int, param2:int) : void
      {
         if(var_549)
         {
            var_549.resize(param1,param2);
         }
      }
   }
}

