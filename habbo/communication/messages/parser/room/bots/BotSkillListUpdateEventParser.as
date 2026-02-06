package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class BotSkillListUpdateEventParser implements IMessageParser
   {
      
      private var var_1504:int;
      
      private var var_3551:Array;
      
      public function BotSkillListUpdateEventParser()
      {
         super();
      }
      
      public function get skillList() : Array
      {
         return var_3551;
      }
      
      public function get botId() : int
      {
         return var_1504;
      }
      
      public function flush() : Boolean
      {
         var_1504 = -1;
         var_3551 = new Array(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1504 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_3551.push(new class_3969(param1));
            _loc3_++;
         }
         return true;
      }
   }
}

