package com.sulake.habbo.communication.messages.parser.room.engine
{
   import com.sulake.core.communication.messages.IMessageDataWrapper;
   import com.sulake.core.communication.messages.IMessageParser;
   
   [SecureSWF(rename="true")]
   public class ObjectRemoveMessageEventParser implements IMessageParser
   {
      
      private var var_197:int;
      
      private var var_4865:Boolean;
      
      private var var_2760:int;
      
      private var var_3154:int;
      
      public function ObjectRemoveMessageEventParser()
      {
         super();
      }
      
      public function get id() : int
      {
         return var_197;
      }
      
      public function get isExpired() : Boolean
      {
         return var_4865;
      }
      
      public function get pickerId() : int
      {
         return var_2760;
      }
      
      public function get delay() : int
      {
         return var_3154;
      }
      
      public function flush() : Boolean
      {
         var_197 = 0;
         var_3154 = 0;
         return true;
      }
      
      public function parse(param1:IMessageDataWrapper) : Boolean
      {
         if(param1 == null)
         {
            return false;
         }
         var_197 = int(param1.readString());
         var_4865 = param1.readBoolean();
         var_2760 = param1.readInteger();
         var_3154 = param1.readInteger();
         return true;
      }
   }
}

