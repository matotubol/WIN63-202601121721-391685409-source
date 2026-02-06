package com.sulake.habbo.communication.messages.parser.collectibles
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CollectableMintableItemTypesMessageEventParser implements IMessageParser
   {
      
      private var var_1850:Vector.<class_4079> = new Vector.<class_4079>(0);
      
      public function CollectableMintableItemTypesMessageEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_1850 = new Vector.<class_4079>(0);
         return false;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_1850.push(new class_4079(param1));
            _loc3_++;
         }
         return true;
      }
      
      public function hasData() : Boolean
      {
         return var_1850.length > 0;
      }
      
      public function get collectibleProductItems() : Vector.<class_4079>
      {
         return var_1850;
      }
   }
}

