package com.sulake.habbo.help.cfh.registry.instantmessage
{
   import com.sulake.core.runtime.class_13;
   import com.sulake.habbo.help.HabboHelp;
   import package_11.class_1825;
   import package_11.class_2137;
   import package_14.class_1792;
   import package_14.class_2028;
   
   public class InstantMessageEventHandler implements class_13
   {
      
      private var var_59:HabboHelp;
      
      public function InstantMessageEventHandler(param1:HabboHelp)
      {
         super();
         var_59 = param1;
         var_59.addMessageEvent(new class_2028(onInstantMessage));
         var_59.addMessageEvent(new class_1792(onRoomInvite));
      }
      
      public function onInstantMessage(param1:class_2028) : void
      {
         var _loc2_:class_2137 = param1.getParser();
         if(_loc2_.chatId < 0)
         {
            var_59.instantMessageRegistry.addItem(_loc2_.chatId,_loc2_.senderName,_loc2_.messageText);
         }
         else
         {
            var_59.instantMessageRegistry.addItem(_loc2_.chatId,_loc2_.senderName,_loc2_.messageText);
         }
      }
      
      public function onRoomInvite(param1:class_1792) : void
      {
         var _loc2_:class_1825 = param1.getParser();
         var_59.instantMessageRegistry.addItem(_loc2_.senderId,"",_loc2_.messageText);
      }
      
      public function dispose() : void
      {
         if(!disposed)
         {
            if(var_59)
            {
               var_59 = null;
            }
         }
      }
      
      public function get disposed() : Boolean
      {
         return var_59 == null;
      }
   }
}

