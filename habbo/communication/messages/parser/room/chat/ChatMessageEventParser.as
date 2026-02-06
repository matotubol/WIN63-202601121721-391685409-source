package com.sulake.habbo.communication.messages.parser.room.chat
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ChatMessageEventParser implements IMessageParser
   {
      
      private var var_1270:int = 0;
      
      private var _text:String = "";
      
      private var var_2621:Array;
      
      private var var_2937:int = 0;
      
      private var var_4920:int = -1;
      
      private var var_3109:int = 0;
      
      public function ChatMessageEventParser()
      {
         super();
      }
      
      public function get userId() : int
      {
         return var_1270;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function get links() : Array
      {
         return var_2621;
      }
      
      public function get gesture() : int
      {
         return var_2937;
      }
      
      public function get trackingId() : int
      {
         return var_4920;
      }
      
      public function get styleId() : int
      {
         return var_3109;
      }
      
      public function flush() : Boolean
      {
         var_1270 = 0;
         _text = "";
         var_2937 = 0;
         var_2621 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_1270 = param1.readInteger();
         _text = param1.readString();
         var_2937 = param1.readInteger();
         var_3109 = param1.readInteger();
         var _loc2_:int = param1.readInteger();
         if(_loc2_ > 0)
         {
            var_2621 = [];
            var _loc3_:int = 0;
            while(0 < _loc2_)
            {
               var_2621.push([param1.readString(),param1.readString(),param1.readBoolean()]);
               _loc3_++;
            }
         }
         var_4920 = param1.readInteger();
         return true;
      }
   }
}

