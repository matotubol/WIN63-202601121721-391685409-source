package com.sulake.habbo.communication.messages.parser.nux
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.nux.class_3217;
   
   [SecureSWF(rename="true")]
   public class NewUserExperienceGiftOfferEventParser implements IMessageParser
   {
      
      private var var_1407:Vector.<class_3217>;
      
      public function NewUserExperienceGiftOfferEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc2_:int = param1.readInteger();
         var_1407 = new Vector.<class_3217>();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_1407.push(new class_3217(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function get giftOptions() : Vector.<class_3217>
      {
         return var_1407;
      }
   }
}

