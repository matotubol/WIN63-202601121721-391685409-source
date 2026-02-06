package com.sulake.habbo.communication.messages.parser.inventory.clothing
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class FigureSetIdsEventParser implements IMessageParser
   {
      
      private var var_3127:Vector.<int>;
      
      private var var_3628:Vector.<String>;
      
      public function FigureSetIdsEventParser()
      {
         super();
      }
      
      public function flush() : Boolean
      {
         var_3127 = new Vector.<int>(0);
         var_3628 = new Vector.<String>(0);
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var _loc3_:int = 0;
         var _loc2_:int = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_3127.push(param1.readInteger());
            _loc3_++;
         }
         _loc2_ = param1.readInteger();
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            var_3628.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
      
      public function get figureSetIds() : Vector.<int>
      {
         return var_3127;
      }
      
      public function get boundFurnitureNames() : Vector.<String>
      {
         return var_3628;
      }
   }
}

