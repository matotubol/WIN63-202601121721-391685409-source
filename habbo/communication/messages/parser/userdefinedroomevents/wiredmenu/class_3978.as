package com.sulake.habbo.communication.messages.parser.userdefinedroomevents.wiredmenu
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import package_97.WiredRoomStatsData;
   
   public class class_3978 implements IMessageParser
   {
      
      private var var_99:WiredRoomStatsData;
      
      public function class_3978()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_99 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_99 = new WiredRoomStatsData(param1);
         return true;
      }
      
      public function get roomStats() : WiredRoomStatsData
      {
         return var_99;
      }
   }
}

