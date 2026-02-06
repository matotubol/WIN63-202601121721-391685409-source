package com.sulake.habbo.communication.messages.parser.room.bots
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   
   [SecureSWF(rename="true")]
   public class class_3969
   {
      
      private var var_197:int;
      
      private var var_24:String;
      
      public function class_3969(param1:IMessageDataWrapper)
      {
         super();
         parse(param1);
      }
      
      public function parse(param1:IMessageDataWrapper) : void
      {
         var_197 = param1.readInteger();
         var_24 = param1.readString();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get data() : String
      {
         return var_24;
      }
   }
}

