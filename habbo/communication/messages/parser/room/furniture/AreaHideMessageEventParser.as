package com.sulake.habbo.communication.messages.parser.room.furniture
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.parser.room.engine.AreaHideMessageData;
   
   [SecureSWF(rename="true")]
   public class AreaHideMessageEventParser implements IMessageParser
   {
      
      private var var_3214:AreaHideMessageData;
      
      public function AreaHideMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3214 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_3214 = new AreaHideMessageData(param1);
         return true;
      }
      
      public function get areaHideMessageData() : AreaHideMessageData
      {
         return var_3214;
      }
   }
}

