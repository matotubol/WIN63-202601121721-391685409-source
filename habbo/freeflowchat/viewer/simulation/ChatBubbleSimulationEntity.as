package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Rectangle;
   
   public class ChatBubbleSimulationEntity
   {
      
      public static const VISUALIZATION_OVERLAP_VERTICAL:int = 10;
      
      protected const MOVE_NEGATIVE_FEEDBACK:Number = 0.1;
      
      protected var _visualization:PooledChatBubble;
      
      protected var var_25:Number;
      
      protected var var_26:Number;
      
      protected var var_60:Rectangle = new Rectangle();
      
      protected var var_90:Rectangle = null;
      
      protected var var_2588:Number;
      
      protected var var_2524:Number;
      
      private const const_1072:int = 2500;
      
      private var var_1747:Vector.<ChatBubbleSimulationEntity> = new Vector.<ChatBubbleSimulationEntity>(0);
      
      private var var_4177:Boolean = false;
      
      public function ChatBubbleSimulationEntity(param1:PooledChatBubble, param2:Boolean = false)
      {
         super();
         _visualization = param1;
         var _loc3_:Rectangle = param1.overlap;
         var_25 = param1.x + (_loc3_ ? _loc3_.x : 0);
         var_26 = param1.y + (_loc3_ ? _loc3_.y : 0);
         var_60.x = var_25;
         var_60.y = var_26;
         var_60.width = _visualization.width - (_loc3_ ? _loc3_.x + _loc3_.width : 0);
         var_60.height = _visualization.displayedHeight - 10 - (_loc3_ ? _loc3_.y + _loc3_.height : 0);
         if(_visualization.minHeight != -1)
         {
            var_60.height = _visualization.minHeight;
         }
         if(param2)
         {
            var_90 = new Rectangle();
            var_90.width = var_60.width + 2 * 2500;
            var_90.height = _visualization.minHeight != -1 ? _visualization.minHeight : var_60.height / 2;
            var_90.x = var_60.x - 2500;
            var_90.y = var_60.y;
         }
      }
      
      public function dispose() : void
      {
         if(_visualization)
         {
            _visualization.readyToRecycle = true;
         }
         _visualization = null;
         var_60 = null;
         var_1747 = null;
         var_90 = null;
      }
      
      public function get y() : Number
      {
         return var_26;
      }
      
      public function set y(param1:Number) : void
      {
         var_26 = param1;
         var_60.y = var_26;
         if(var_90)
         {
            var_90.y = var_60.y;
         }
      }
      
      public function get x() : Number
      {
         return var_25;
      }
      
      public function set x(param1:Number) : void
      {
         var_25 += (param1 - var_25) * (1 - 0.1);
         var_60.x = var_25;
         if(var_90)
         {
            var_90.x = var_60.x - 2500;
         }
      }
      
      public function get visualRect() : Rectangle
      {
         return var_60;
      }
      
      public function get wideRect() : Rectangle
      {
         return var_90 ? var_90 : var_60;
      }
      
      public function get hasWideRect() : Boolean
      {
         return var_90 != null;
      }
      
      public function get centerX() : Number
      {
         return var_25 + var_60.width / 2;
      }
      
      public function initializePosition(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = _visualization.overlap;
         var_25 = param1 + (_loc3_ ? _loc3_.x : 0);
         var_26 = param2 + (_loc3_ ? _loc3_.y : 0);
         var_60.x = var_25;
         var_60.y = var_26;
         if(var_90)
         {
            var_90.x = var_60.x - 2500;
            var_90.y = var_60.y;
         }
      }
      
      public function addHorizontalImpulse(param1:Number) : void
      {
         var_2588 += param1;
      }
      
      public function addCollisionHandled(param1:ChatBubbleSimulationEntity) : void
      {
         var_1747.push(param1);
      }
      
      public function hasCollidedWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         return var_1747.indexOf(param1) != -1;
      }
      
      public function addVerticalImpulse(param1:Number) : void
      {
         var_2524 += param1;
      }
      
      public function applyImpulseForces(param1:int) : void
      {
         x += var_2588;
         y += Math.max(var_2524,-param1);
      }
      
      public function resetSimulationStep() : void
      {
         var_2588 = 0;
         var_2524 = 0;
         var_1747 = new Vector.<ChatBubbleSimulationEntity>(0);
      }
      
      public function syncToVisualization(param1:Boolean = false) : void
      {
         var _loc2_:Rectangle = _visualization.overlap;
         if(!param1)
         {
            _visualization.moveTo(int(var_25 - (_loc2_ ? _loc2_.x : 0)),int(var_26 - (_loc2_ ? _loc2_.y : 0)));
         }
         else
         {
            _visualization.warpTo(int(var_25 - (_loc2_ ? _loc2_.x : 0)),int(var_26 - (_loc2_ ? _loc2_.y : 0)));
         }
      }
      
      public function set fullHeightCollision(param1:Boolean) : void
      {
         if(var_90)
         {
            var_90.height = param1 ? var_60.height : var_60.height / 2;
         }
      }
      
      public function get visualizationHasHitMargin() : Boolean
      {
         return _visualization.hasHitDesktopMargin;
      }
      
      public function set readyToRecycle(param1:Boolean) : void
      {
         _visualization.readyToRecycle = param1;
      }
      
      public function get readyToRecycle() : Boolean
      {
         return _visualization.readyToRecycle;
      }
      
      public function get timeStamp() : uint
      {
         return _visualization.timeStamp;
      }
      
      public function get isSpacer() : Boolean
      {
         return var_4177;
      }
      
      public function set isSpacer(param1:Boolean) : void
      {
         var_4177 = param1;
      }
      
      public function intersectsWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         if(var_90)
         {
            return var_60.intersects(param1.var_60) || var_90.intersects(param1.wideRect);
         }
         if(param1.var_90)
         {
            return var_60.intersects(param1.var_60) || var_60.intersects(param1.var_90);
         }
         return var_60.intersects(param1.var_60);
      }
      
      public function visualIntertersectsWith(param1:ChatBubbleSimulationEntity) : Boolean
      {
         return var_60.intersects(param1.var_60);
      }
   }
}

