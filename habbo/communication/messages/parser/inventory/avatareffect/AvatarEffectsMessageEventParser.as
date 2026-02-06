package com.sulake.habbo.communication.messages.parser.inventory.avatareffect
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.avatareffect.class_2943;
   
   [SecureSWF(rename="true")]
   public class AvatarEffectsMessageEventParser implements IMessageParser
   {
      
      private var var_555:Array;
      
      public function AvatarEffectsMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_555 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_555 = [];
         var _loc3_:int = param1.readInteger();
         var _loc4_:int = 0;
         while(0 < _loc3_)
         {
            var _loc2_:class_2943 = new class_2943();
            null.type = param1.readInteger();
            null.subType = param1.readInteger();
            null.duration = param1.readInteger();
            null.inactiveEffectsInInventory = param1.readInteger();
            null.secondsLeftIfActive = param1.readInteger();
            null.isPermanent = param1.readBoolean();
            var_555.push(null);
            _loc4_++;
         }
         return true;
      }
      
      public function get effects() : Array
      {
         return var_555;
      }
   }
}

