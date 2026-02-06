package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectExpiredMessageEventParser implements IMessageParser
   {
      
      private var var_230:int;
      
      public function AvatarEffectExpiredMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_230 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_230 = param1.readInteger();
         return true;
      }
      
      public function get type() : int
      {
         return var_230;
      }
   }
}

