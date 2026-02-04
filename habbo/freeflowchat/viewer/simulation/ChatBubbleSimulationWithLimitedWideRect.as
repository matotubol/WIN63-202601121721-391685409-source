package com.sulake.habbo.freeflowchat.viewer.simulation
{
   import com.sulake.habbo.freeflowchat.viewer.visualization.PooledChatBubble;
   import flash.geom.Rectangle;
   
   public class ChatBubbleSimulationWithLimitedWideRect extends ChatBubbleSimulationEntity
   {
      
      public static const WIDERECT_WIDTH:int = 240;
      
      private var _wideRectOffset:Number;
      
      public function ChatBubbleSimulationWithLimitedWideRect(param1:PooledChatBubble)
      {
         super(param1,false);
         var_90 = new Rectangle();
         var_90.width = 240;
         var_90.height = var_60.height / 2;
         _wideRectOffset = -(240 - var_60.width) / 2;
         var_90.x = var_60.x + _wideRectOffset;
         var_90.y = var_60.y;
      }
      
      override public function set x(param1:Number) : void
      {
         var_25 += (param1 - var_25) * (1 - 0.1);
         var_60.x = var_25;
         if(var_90)
         {
            var_90.x = var_60.x + _wideRectOffset;
         }
      }
      
      override public function initializePosition(param1:Number, param2:Number) : void
      {
         var _loc3_:Rectangle = _visualization.overlap;
         var_25 = param1 + (_loc3_ ? _loc3_.x : 0);
         var_26 = param2 + (_loc3_ ? _loc3_.y : 0);
         var_60.x = var_25;
         var_60.y = var_26;
         if(var_90)
         {
            var_90.x = var_60.x + _wideRectOffset;
            var_90.y = var_60.y;
         }
      }
      
      public function get wideRectOffset() : Number
      {
         return _wideRectOffset;
      }
      
      public function set wideRectOffset(param1:Number) : void
      {
         _wideRectOffset = param1;
      }
   }
}

