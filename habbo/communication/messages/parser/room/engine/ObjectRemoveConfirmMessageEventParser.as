package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveConfirmMessageEventParser implements IMessageParser
   {
      
      private var var_191:int;
      
      private var var_197:int;
      
      private var var_2791:String;
      
      private var var_2841:String;
      
      public function ObjectRemoveConfirmMessageEventParser()
      {
         super();
      }
      
      public function get category() : int
      {
         return var_191;
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get confirmTitle() : String
      {
         return var_2791;
      }
      
      public function get confirmBody() : String
      {
         return var_2841;
      }
      
      public function flush() : Boolean
      {
         var_191 = 0;
         var_197 = 0;
         var_2841 = null;
         var_2791 = null;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_191 = param1.readInteger() == 1 ? 20 : 10;
         var_197 = param1.readInteger();
         var_2791 = param1.readString();
         var_2841 = param1.readString();
         return true;
      }
   }
}

