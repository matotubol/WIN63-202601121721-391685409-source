package com.sulake.habbo.communication.messages.parser.room.action
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int = 0;
      
      private var var_2200:int = 0;
      
      private var var_4011:int = 0;
      
      public function AvatarEffectMessageEventParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get effectId() : int
      {
         return var_2200;
      }
      
      public function get delayMilliSeconds() : int
      {
         return var_4011;
      }
      
      public function flush() : Boolean
      {
         var_1270 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_1270 = param1.readInteger();
         var_2200 = param1.readInteger();
         var_4011 = param1.readInteger();
         return true;
      }
   }
}

