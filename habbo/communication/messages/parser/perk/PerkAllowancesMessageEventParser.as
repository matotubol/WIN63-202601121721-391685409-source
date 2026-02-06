package com.sulake.habbo.communication.messages.parser.perk
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class PerkAllowancesMessageEventParser implements IMessageParser
   {
      
      private var var_1035:Vector.<class_2995>;
      
      public function PerkAllowancesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1035 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1035 = new Vector.<class_2995>();
         var _loc2_:int = param1.readInteger();
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var _loc4_:class_2995 = new class_2995();
            _loc4_.code = param1.readString();
            null.errorMessage = param1.readString();
            null.isAllowed = param1.readBoolean();
            var_1035.push(null);
            _loc3_++;
         }
         return true;
      }
      
      public function getPerks() : Vector.<class_2995>
      {
         return var_1035;
      }
      
      public function isPerkAllowed(param1:String) : Boolean
      {
         var _loc2_:class_2995 = getPerk(param1);
         return _loc2_ != null && _loc2_.isAllowed;
      }
      
      public function getPerk(param1:String) : class_2995
      {
         for each(var _loc2_ in var_1035)
         {
            if(_loc2_.code == param1)
            {
               return _loc2_;
            }
         }
         return null;
      }
   }
}

