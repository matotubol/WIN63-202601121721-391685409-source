package com.sulake.habbo.communication.messages.parser.inventory.trading
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   import com.sulake.habbo.communication.messages.incoming.inventory.trading.class_3066;
   
   [SecureSWF(rename="true")]
   public class TradingItemListEventParser implements IMessageParser
   {
      
      private var var_3019:int;
      
      private var var_2632:Array;
      
      private var var_2713:int;
      
      private var var_2880:int;
      
      private var var_3344:int;
      
      private var var_2240:Array;
      
      private var var_3390:int;
      
      private var var_2727:int;
      
      public function TradingItemListEventParser()
      {
         super();
      }
      
      public function get firstUserID() : int
      {
         return var_3019;
      }
      
      public function get firstUserItemArray() : Array
      {
         return var_2632;
      }
      
      public function get firstUserNumItems() : int
      {
         return var_2713;
      }
      
      public function get firstUserNumCredits() : int
      {
         return var_2880;
      }
      
      public function get secondUserID() : int
      {
         return var_3344;
      }
      
      public function get secondUserItemArray() : Array
      {
         return var_2240;
      }
      
      public function get secondUserNumItems() : int
      {
         return var_3390;
      }
      
      public function get secondUserNumCredits() : int
      {
         return var_2727;
      }
      
      public function flush() : Boolean
      {
         var_3019 = -1;
         var_2632 = null;
         var_2713 = 0;
         var_2880 = 0;
         var_3344 = -1;
         var_2240 = null;
         var_3390 = 0;
         var_2727 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_3019 = param1.readInteger();
         var_2632 = [];
         if(!parseItemData(param1,var_2632))
         {
            return false;
         }
         var_2713 = param1.readInteger();
         var_2880 = param1.readInteger();
         var_3344 = param1.readInteger();
         var_2240 = [];
         if(!parseItemData(param1,var_2240))
         {
            return false;
         }
         var_3390 = param1.readInteger();
         var_2727 = param1.readInteger();
         return true;
      }
      
      private function parseItemData(param1:IMessageDataWrapper, param2:Array) : Boolean
      {
         var _loc3_:int = 0;
         _loc3_ = param1.readInteger();
         while(_loc3_ > 0)
         {
            param2.push(new class_3066(param1));
            _loc3_--;
         }
         return true;
      }
   }
}

