package com.sulake.habbo.game
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.class_57;
   import package_23.class_3074;
   import package_23.class_3442;
   import package_23.class_3617;
   
   public class IncomingMessages implements class_13
   {
      
      private var _gameManager:HabboGameManager;
      
      private var var_1134:Boolean = false;
      
      public function IncomingMessages(param1:HabboGameManager)
      {
         super();
         _gameManager = param1;
         var _loc2_:class_57 = _gameManager.communication;
         _loc2_.addHabboConnectionMessageEvent(new class_3074(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new class_3617(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new class_3442(onHotelClosed));
      }
      
      public function dispose() : void
      {
         _gameManager = null;
         var_1134 = true;
      }
      
      public function get disposed() : Boolean
      {
         return var_1134;
      }
      
      private function onHotelClosed(param1:IMessageEvent) : void
      {
         _gameManager.hotelClosed = true;
      }
   }
}

