package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectActivatedMessageEventParser implements IMessageParser
   {
      
      private var var_230:int;
      
      private var var_2740:int;
      
      private var var_3835:Boolean;
      
      public function AvatarEffectActivatedMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_230 = 0;
         var_2740 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_230 = param1.readInteger();
         var_2740 = param1.readInteger();
         var_3835 = param1.readBoolean();
         return true;
      }
      
      public function get type() : int
      {
         return var_230;
      }
      
      public function get duration() : int
      {
         return var_2740;
      }
      
      public function get isPermanent() : Boolean
      {
         return var_3835;
      }
   }
}

