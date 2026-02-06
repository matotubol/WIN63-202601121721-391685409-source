package com.sulake.habbo.game
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.class_57;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosingMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.InfoHotelClosedMessageEvent;
   import com.sulake.habbo.communication.messages.incoming.availability.MaintenanceStatusMessageEvent;
   
   public class IncomingMessages implements class_13
   {
      
      private var _gameManager:HabboGameManager;
      
      private var var_1134:Boolean = false;
      
      public function IncomingMessages(param1:HabboGameManager)
      {
         super();
         _gameManager = param1;
         var _loc2_:class_57 = _gameManager.communication;
         _loc2_.addHabboConnectionMessageEvent(new InfoHotelClosingMessageEvent(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new MaintenanceStatusMessageEvent(onHotelClosed));
         _loc2_.addHabboConnectionMessageEvent(new InfoHotelClosedMessageEvent(onHotelClosed));
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

