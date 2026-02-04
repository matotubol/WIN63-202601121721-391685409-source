package com.sulake.habbo.roomevents
{
   import com.sulake.core.communication.messages.IMessageEvent;
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3133;
   import com.sulake.habbo.communication.messages.incoming.userdefinedroomevents.class_3645;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_2795;
   import com.sulake.habbo.communication.messages.parser.userdefinedroomevents.class_3453;
   import com.sulake.habbo.roomevents.events.WiredUserClickHandledEvent;
   
   public class WiredEnvironment implements class_13
   {
      
      private var _disposed:Boolean;
      
      private var name_1:HabboUserDefinedRoomEvents;
      
      private var _messageEvents:Array;
      
      private var var_2167:Boolean = false;
      
      public function WiredEnvironment(param1:HabboUserDefinedRoomEvents)
      {
         super();
         name_1 = param1;
         _messageEvents = [];
         _messageEvents.push(new class_3133(onWiredEnvironmentEvent));
         _messageEvents.push(new class_3645(onWiredClickUserResponseEvent));
         for each(var _loc2_ in _messageEvents)
         {
            name_1.communication.addHabboConnectionMessageEvent(_loc2_);
         }
      }
      
      private function onWiredEnvironmentEvent(param1:class_3133) : void
      {
         var _loc2_:class_3453 = param1.getParser();
         var_2167 = _loc2_.hasClickUserWired;
      }
      
      private function onWiredClickUserResponseEvent(param1:class_3645) : void
      {
         var _loc2_:class_2795 = param1.getParser();
         name_1.events.dispatchEvent(new WiredUserClickHandledEvent("WIRED_USER_CLICK_HANDLED",_loc2_.index,_loc2_.openMenu));
      }
      
      public function clear() : void
      {
         var_2167 = false;
      }
      
      public function get hasClickUserWired() : Boolean
      {
         return var_2167;
      }
      
      public function dispose() : void
      {
         if(_disposed)
         {
            return;
         }
         _disposed = true;
         var_2167 = false;
         for each(var _loc1_ in _messageEvents)
         {
            name_1.communication.removeHabboConnectionMessageEvent(_loc1_);
         }
         _messageEvents = null;
         name_1 = null;
      }
      
      public function get disposed() : Boolean
      {
         return _disposed;
      }
   }
}

