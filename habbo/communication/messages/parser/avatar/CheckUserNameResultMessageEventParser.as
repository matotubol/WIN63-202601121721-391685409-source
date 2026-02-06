package com.sulake.habbo.communication.messages.parser.avatar
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class CheckUserNameResultMessageEventParser implements IMessageParser
   {
      
      private var var_1587:int = -1;
      
      private var _name:String;
      
      private var var_2512:Array;
      
      public function CheckUserNameResultMessageEventParser()
      {
         super();
      }
      
      public function get resultCode() : int
      {
         return var_1587;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get nameSuggestions() : Array
      {
         return var_2512;
      }
      
      public function flush() : Boolean
      {
         var_1587 = -1;
         _name = "";
         var_2512 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_1587 = param1.readInteger();
         _name = param1.readString();
         var _loc2_:int = param1.readInteger();
         var_2512 = [];
         var _loc3_:int = 0;
         while(0 < _loc2_)
         {
            var_2512.push(param1.readString());
            _loc3_++;
         }
         return true;
      }
   }
}

