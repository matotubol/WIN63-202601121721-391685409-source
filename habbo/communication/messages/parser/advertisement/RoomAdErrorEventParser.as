package com.sulake.habbo.communication.messages.parser.advertisement
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class RoomAdErrorEventParser implements IMessageParser
   {
      
      private var var_2759:int = 0;
      
      private var var_4902:String;
      
      public function RoomAdErrorEventParser()
      {
         super();
      }
      
      public function get errorCode() : int
      {
         return var_2759;
      }
      
      public function get filteredText() : String
      {
         return var_4902;
      }
      
      public function flush() : Boolean
      {
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         var_2759 = param1.readInteger();
         var_4902 = param1.readString();
         return true;
      }
   }
}

